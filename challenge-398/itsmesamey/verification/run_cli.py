#!/usr/bin/env python3
"""Finite entry-point coverage using retained independent oracle cases."""

import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import resource
import signal

# The caller selects local tools; subprocess receives argv without a shell.
import subprocess  # nosec B404
import time


def sha(path):
    """Hash the complete contents of a file."""
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def memory(pid):
    """Read current and high-water memory from Linux procfs."""
    try:
        return {
            line.split(":")[0]: int(line.split()[1]) * 1024
            for line in Path(f"/proc/{pid}/status").read_text().splitlines()
            if line.startswith(("VmRSS:", "VmHWM:"))
        }
    except (FileNotFoundError, ProcessLookupError):
        return {}


def main():
    """Run the thirteen frozen CLI checks and retain exact channel results."""
    p = argparse.ArgumentParser()
    p.add_argument("--manifest", required=True)
    p.add_argument("--output", required=True)
    p.add_argument("--cpu", required=True, type=int)
    args = p.parse_args()
    manifest = json.loads(Path(args.manifest).read_text())
    for path, digest in manifest["files"].items():
        if sha(path) != digest:
            raise SystemExit(f"pin mismatch: {path}")
    if str(Path(__file__).resolve()) not in manifest["files"]:
        raise SystemExit("runner is not pinned")
    if args.cpu not in os.sched_getaffinity(0):
        raise SystemExit("CPU unavailable")
    output = Path(args.output).resolve()
    output.mkdir(exist_ok=False)
    os.sched_setaffinity(0, {args.cpu})
    start = time.monotonic()
    before = resource.getrusage(resource.RUSAGE_SELF)
    before_child = resource.getrusage(resource.RUSAGE_CHILDREN)
    result = {
        "status": "FAIL",
        "errors": [],
        "cases": [],
        "cpu": args.cpu,
        "manifest_sha256": sha(args.manifest),
        "wall_limit_seconds": 20,
        "work_alarm_seconds": 17,
        "cleanup_reserve_seconds": 3,
        "rss_limit_bytes": 256 * 1048576,
        "sampled_peak_rss_bytes": 0,
        "initial_self_ru_maxrss_kib": before.ru_maxrss,
        "initial_children_ru_maxrss_kib": before_child.ru_maxrss,
        "initial_proc_memory": memory(os.getpid()),
        "processes": [],
    }
    proc = None
    identity = None
    helpers = None
    known = {}

    def check():
        members = []
        if proc is not None and identity is not None:
            active_helpers = helpers
            if active_helpers is None:
                raise RuntimeError(
                    "Process helpers unavailable for owned-process check"
                )
            if active_helpers.process_identity(proc.pid) == identity:
                members = active_helpers.group_members(proc.pid)
                for pid in members:
                    item = active_helpers.process_identity(pid)
                    if item is not None and item["pgrp"] == proc.pid:
                        known[pid] = item
            else:
                members = [
                    pid
                    for pid, item in known.items()
                    if active_helpers.process_identity(pid) == item
                ]
        rss = memory(os.getpid()).get("VmRSS", 0) + sum(
            memory(pid).get("VmRSS", 0) for pid in members
        )
        result["sampled_peak_rss_bytes"] = max(result["sampled_peak_rss_bytes"], rss)
        if rss > result["rss_limit_bytes"]:
            raise MemoryError("sampled owned aggregate RSS exceeds limit")

    def alarm(signum, frame):
        raise TimeoutError("17-second work deadline")

    def cleanup():
        if proc is None:
            return
        active_helpers = helpers
        if active_helpers is None:
            raise RuntimeError("Process helpers unavailable for owned-process cleanup")
        live = active_helpers.group_members(proc.pid)
        receipt = {"pid": proc.pid, "identity": identity, "live_before": live}
        if live:
            if (
                identity is not None
                and active_helpers.process_identity(proc.pid) == identity
            ):
                try:
                    os.killpg(proc.pid, signal.SIGKILL)
                except ProcessLookupError:
                    pass
            else:
                for pid in live:
                    if (
                        pid in known
                        and active_helpers.process_identity(pid) == known[pid]
                    ):
                        try:
                            os.kill(pid, signal.SIGKILL)
                        except ProcessLookupError:
                            pass
            result["errors"].append("CLI process group required cleanup")
        try:
            proc.wait(timeout=3)
        except subprocess.TimeoutExpired:
            result["errors"].append("CLI process failed to reap")
        receipt["live_after"] = active_helpers.group_members(proc.pid)
        receipt["exit"] = proc.returncode
        result["processes"].append(receipt)
        if receipt["live_after"]:
            result["errors"].append("CLI owned processes remain")

    signal.signal(signal.SIGALRM, alarm)
    signal.setitimer(signal.ITIMER_REAL, 17)
    try:
        spec = importlib.util.spec_from_file_location(
            "reviewed_helpers", manifest["helpers"]
        )
        if spec is None or spec.loader is None:
            raise ImportError("Cannot load the pinned process-helper module")
        helpers = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(helpers)
        check()
        requested = manifest["case_ids"]
        selected = {}
        for line in Path(manifest["oracle_cases"]).open():
            case = json.loads(line)
            if case["id"] in requested:
                if case["id"] in selected:
                    raise ValueError("duplicate selected oracle case")
                selected[case["id"]] = case
        if set(selected) != set(requested) or len(requested) != 13:
            raise ValueError("CLI frozen case selection mismatch")
        env = os.environ.copy()
        for key in ("PERL5OPT", "PERL5LIB", "PERLLIB", "PERL_UNICODE"):
            env.pop(key, None)
        env["LC_ALL"] = "C.UTF-8"
        for case_id in requested:
            check()
            case = selected[case_id]
            command = [
                manifest["perl"],
                str(Path(manifest["candidate_dir"]) / f"ch-{case['task']}.pl"),
                *case["input"],
            ]
            if not all(isinstance(item, str) for item in command):
                raise ValueError("non-string CLI argument")
            stdout_path = output / (case_id + ".stdout")
            stderr_path = output / (case_id + ".stderr")

            def limits():
                resource.setrlimit(resource.RLIMIT_CPU, (5, 5))
                resource.setrlimit(resource.RLIMIT_CORE, (0, 0))
                resource.setrlimit(resource.RLIMIT_FSIZE, (65536, 65536))

            with stdout_path.open("xb") as out, stderr_path.open("xb") as err:
                # Caller-trusted Perl, checked scripts and case strings use argv.
                proc = subprocess.Popen(  # nosec B603
                    command,
                    stdin=subprocess.DEVNULL,
                    stdout=out,
                    stderr=err,
                    cwd=output,
                    env=env,
                    start_new_session=True,
                    preexec_fn=limits,
                )
                identity = helpers.process_identity(proc.pid)
                known = {}
                if identity is None or identity["pgrp"] != proc.pid:
                    raise RuntimeError("cannot bind CLI process identity")
                known[proc.pid] = identity
                while proc.poll() is None:
                    check()
                    time.sleep(0.005)
            actual_out, actual_err = stdout_path.read_bytes(), stderr_path.read_bytes()
            expected = case["expected"]
            if expected.get("error"):
                expected_out = b""
                expected_err = manifest["error_stderr"][case_id].encode("ascii")
                expected_exit = 2
            else:
                expected_out = (
                    expected.get("declared_output", expected.get("output")) + "\n"
                ).encode("ascii")
                expected_err = b""
                expected_exit = 0
            passed = (
                actual_out == expected_out
                and actual_err == expected_err
                and proc.returncode == expected_exit
            )
            result["cases"].append(
                {
                    "id": case_id,
                    "command": command,
                    "oracle_case": case,
                    "expected_exit": expected_exit,
                    "actual_exit": proc.returncode,
                    "expected_stdout": expected_out.decode("ascii"),
                    "expected_stderr": expected_err.decode("ascii"),
                    "pass": passed,
                    "stdout_sha256": sha(stdout_path),
                    "stderr_sha256": sha(stderr_path),
                }
            )
            cleanup()
            proc = None
            identity = None
            if not passed or result["errors"]:
                raise ValueError(f"CLI check failed: {case_id}")
        if len(result["cases"]) == 13:
            result["status"] = "PASS"
    except BaseException as exc:
        result["errors"].append(f"{type(exc).__name__}: {exc}")
    finally:
        signal.setitimer(signal.ITIMER_REAL, 0)
        cleanup()
        after = resource.getrusage(resource.RUSAGE_SELF)
        after_child = resource.getrusage(resource.RUSAGE_CHILDREN)
        result["wall_seconds"] = time.monotonic() - start
        result["cpu_seconds"] = (
            after.ru_utime
            + after.ru_stime
            - before.ru_utime
            - before.ru_stime
            + after_child.ru_utime
            + after_child.ru_stime
            - before_child.ru_utime
            - before_child.ru_stime
        )
        result["final_self_ru_maxrss_kib"] = after.ru_maxrss
        result["final_proc_memory"] = memory(os.getpid())
        result["children_ru_maxrss_kib"] = after_child.ru_maxrss
        result["final_pins"] = {path: sha(path) for path in manifest["files"]}
        if result["final_pins"] != manifest["files"]:
            result["errors"].append("pins changed")
        if result["errors"] or len(result["cases"]) != 13:
            result["status"] = "FAIL"
        result["passed"] = sum(case["pass"] for case in result["cases"])
        (output / "RESULT.json").write_text(
            json.dumps(result, indent=2, sort_keys=True) + "\n"
        )
    print(
        json.dumps(
            {
                "status": result["status"],
                "passed": result["passed"],
                "errors": result["errors"],
            }
        )
    )
    return 0 if result["status"] == "PASS" else 1


if __name__ == "__main__":
    raise SystemExit(main())
