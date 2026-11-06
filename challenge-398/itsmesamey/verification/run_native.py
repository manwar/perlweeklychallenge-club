#!/usr/bin/env python3
"""Single-batch native qualification; no task algorithms live here."""

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
import sys
import time


def digest(path):
    """Hash a file incrementally without loading its complete contents."""
    h = hashlib.sha256()
    with open(path, "rb") as stream:
        for block in iter(lambda: stream.read(1048576), b""):
            h.update(block)
    return h.hexdigest()


def encode(value):
    """Serialize deterministic ASCII JSON for the retained case records."""
    return json.dumps(value, ensure_ascii=True, sort_keys=True, separators=(",", ":"))


def read_memory(pid):
    """Read current resident bytes, returning zero for an exited process."""
    try:
        for line in Path(f"/proc/{pid}/status").read_text().splitlines():
            if line.startswith("VmRSS:"):
                return int(line.split()[1]) * 1024
    except (FileNotFoundError, ProcessLookupError):
        pass
    return 0


def process_identity(pid):
    """Read PID, process group and start time for owned-process cleanup."""
    try:
        raw = Path(f"/proc/{pid}/stat").read_text()
        fields = raw[raw.rfind(")") + 2 :].split()
        return {"pid": pid, "pgrp": int(fields[2]), "start_ticks": int(fields[19])}
    except (FileNotFoundError, ProcessLookupError):
        return None


def group_members(pgid):
    """List non-zombie members of one Linux process group."""
    result = []
    for item in Path("/proc").iterdir():
        if not item.name.isdigit():
            continue
        try:
            raw = (item / "stat").read_text()
            fields = raw[raw.rfind(")") + 2 :].split()
            if int(fields[2]) == pgid and fields[0] != "Z":
                result.append(int(item.name))
        except (FileNotFoundError, ProcessLookupError, PermissionError):
            continue
    return result


def main():
    """Run the frozen batch, retain comparisons and clean owned processes."""
    parser = argparse.ArgumentParser()
    parser.add_argument("--manifest", required=True)
    parser.add_argument("--output", required=True)
    parser.add_argument("--cpu", required=True, type=int)
    parser.add_argument("--wall-seconds", type=int, default=60)
    parser.add_argument("--rss-mib", type=int, default=256)
    args = parser.parse_args()
    if args.cpu not in os.sched_getaffinity(0):
        raise SystemExit("selected CPU is not in allowed affinity")
    if not 4 <= args.wall_seconds <= 60 or not 1 <= args.rss_mib <= 256:
        raise SystemExit("limits exceed the reviewed envelope")
    output = Path(args.output).resolve()
    if output.exists():
        raise SystemExit("output already exists; refusing replay")
    manifest_path = Path(args.manifest).resolve()
    manifest = json.loads(manifest_path.read_text())
    for path, expected in manifest["files"].items():
        if digest(path) != expected:
            raise SystemExit(f"source pin mismatch: {path}")
    required = [
        str(Path(__file__).resolve()),
        manifest["oracle"],
        manifest["adapter"],
        manifest["perl"],
        str(Path(manifest["candidate_dir"]) / "ch-1.pl"),
        str(Path(manifest["candidate_dir"]) / "ch-2.pl"),
    ]
    if any(path not in manifest["files"] for path in required):
        raise SystemExit("manifest lacks a required executable/source pin")
    output.mkdir(parents=True, exist_ok=False)
    start = time.monotonic()
    start_self = resource.getrusage(resource.RUSAGE_SELF)
    start_child = resource.getrusage(resource.RUSAGE_CHILDREN)
    os.sched_setaffinity(0, {args.cpu})
    result = {
        "status": "FAIL",
        "manifest_sha256": digest(manifest_path),
        "source_pins": manifest["files"],
        "cpu": args.cpu,
        "wall_limit_seconds": args.wall_seconds,
        "work_alarm_seconds": args.wall_seconds - 3,
        "cleanup_reserve_seconds": 3,
        "rss_limit_bytes": args.rss_mib * 1048576,
        "errors": [],
        "native_exit": None,
        "observed_peak_rss_bytes": 0,
        "sampling_interval_seconds": 0.02,
    }
    proc = None
    leader_identity = None
    known_identities = {}
    old_alarm = signal.getsignal(signal.SIGALRM)

    def checkpoint(phase):
        members = []
        if proc is not None and leader_identity is not None:
            if process_identity(proc.pid) == leader_identity:
                members = group_members(proc.pid)
                for pid in members:
                    identity = process_identity(pid)
                    if identity is not None and identity["pgrp"] == proc.pid:
                        known_identities[pid] = identity
            else:
                members = [
                    pid
                    for pid, identity in known_identities.items()
                    if process_identity(pid) == identity
                ]
        rss = read_memory(os.getpid()) + sum(read_memory(pid) for pid in members)
        result["observed_peak_rss_bytes"] = max(result["observed_peak_rss_bytes"], rss)
        result["last_rss_phase"] = phase
        if rss > result["rss_limit_bytes"]:
            raise MemoryError(
                f"sampled supervisor plus owned group RSS exceeded limit in {phase}"
            )

    def alarm_handler(signum, frame):
        raise TimeoutError("outer wall limit reached")

    signal.signal(signal.SIGALRM, alarm_handler)
    signal.setitimer(signal.ITIMER_REAL, args.wall_seconds - 3)
    try:
        checkpoint("before_oracle_import")
        spec = importlib.util.spec_from_file_location(
            "weekly398_independent_oracle", manifest["oracle"]
        )
        if spec is None or spec.loader is None:
            raise ImportError("Cannot load the pinned independent-oracle module")
        oracle = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(oracle)
        checkpoint("after_oracle_import")
        cases = []
        for case in oracle.iter_cases():
            cases.append(case)
            if len(cases) % 128 == 0:
                checkpoint("oracle_generation")
        checkpoint("oracle_generation_complete")
        ids = [case["id"] for case in cases]
        if len(set(ids)) != len(ids) or len(cases) != manifest["case_count"]:
            raise ValueError("oracle duplicate IDs or unexpected case count")
        if not all(isinstance(x, str) and x for x in ids):
            raise ValueError("oracle IDs must be nonempty strings")
        requests = output / "stdin.jsonl"
        expected_file = output / "cases.jsonl"
        with (
            requests.open("w", encoding="ascii", newline="\n") as req,
            expected_file.open("w", encoding="ascii", newline="\n") as exp,
        ):
            for index, case in enumerate(cases):
                req.write(
                    encode({key: case[key] for key in ("id", "task", "input")}) + "\n"
                )
                exp.write(encode(case) + "\n")
                if index % 128 == 0:
                    checkpoint("fixture_serialization")
        result["case_count"] = len(cases)
        result["input_sha256"] = digest(requests)
        result["cases_sha256"] = digest(expected_file)
        result["scope_counts"] = {}
        for case in cases:
            scope = case.get("scope", "unspecified")
            result["scope_counts"][scope] = result["scope_counts"].get(scope, 0) + 1
        env = os.environ.copy()
        removed = []
        for key in ("PERL5OPT", "PERL5LIB", "PERLLIB", "PERL_UNICODE"):
            if key in env:
                removed.append(key)
                env.pop(key)
        env["LC_ALL"] = "C.UTF-8"
        result["environment_overrides"] = {"LC_ALL": "C.UTF-8"}
        result["environment_keys_removed"] = removed
        command = [manifest["perl"], manifest["adapter"], manifest["candidate_dir"]]
        result["command"] = command

        def native_limits():
            resource.setrlimit(resource.RLIMIT_CPU, (55, 55))
            resource.setrlimit(resource.RLIMIT_FSIZE, (16777216, 16777216))
            resource.setrlimit(resource.RLIMIT_CORE, (0, 0))

        with (
            requests.open("rb") as inp,
            (output / "stdout.raw").open("wb") as stdout,
            (output / "stderr.raw").open("wb") as stderr,
        ):
            # Caller-trusted Perl and checked adapter use argv; data uses stdin.
            proc = subprocess.Popen(  # nosec B603
                command,
                stdin=inp,
                stdout=stdout,
                stderr=stderr,
                cwd=output,
                env=env,
                start_new_session=True,
                preexec_fn=native_limits,
            )
            result["native_pid"] = proc.pid
            leader_identity = process_identity(proc.pid)
            result["native_leader_identity"] = leader_identity
            if leader_identity is None or leader_identity["pgrp"] != proc.pid:
                raise RuntimeError("unable to bind the native leader identity")
            known_identities[proc.pid] = leader_identity
            while proc.poll() is None:
                checkpoint("native_batch")
                time.sleep(0.02)
            result["native_exit"] = proc.returncode
        if proc.returncode != 0:
            result["errors"].append(f"native exited {proc.returncode}")
        if (output / "stderr.raw").stat().st_size:
            result["errors"].append("unexpected native stderr")
        native_metadata = json.loads((output / "native-metadata.json").read_text())
        if (
            set(native_metadata) != {"perl_version", "modules"}
            or not isinstance(native_metadata["perl_version"], str)
            or set(native_metadata["modules"]) != {"Math::BigInt", "JSON::PP"}
            or not all(
                isinstance(value, str) and value
                for value in native_metadata["modules"].values()
            )
        ):
            raise ValueError("invalid native version metadata")
        result["native_metadata"] = native_metadata
        records = []
        checkpoint("before_output_parse")
        with (output / "stdout.raw").open(encoding="utf-8") as stream:
            for line in stream:
                value = json.loads(line)
                if not isinstance(value, dict):
                    raise ValueError("native record is not an object")
                records.append(value)
                if len(records) % 128 == 0:
                    checkpoint("output_parse")
        if len(records) != len(cases):
            result["errors"].append("native record count differs from oracle count")
        seen = set()
        outcomes = []
        for index, case in enumerate(cases):
            if index % 128 == 0:
                checkpoint("oracle_verification")
            actual = records[index] if index < len(records) else None
            reasons = []
            if actual is None:
                reasons.append("missing record")
            else:
                if (
                    actual.get("id") != case["id"]
                    or type(actual.get("task")) is not int
                    or actual["task"] != case["task"]
                ):
                    reasons.append("record ID/order/task mismatch")
                if actual.get("id") in seen:
                    reasons.append("duplicate native ID")
                seen.add(actual.get("id"))
                expected = case["expected"]
                if expected.get("error") is True:
                    if (
                        set(actual) != {"id", "task", "error"}
                        or not isinstance(actual.get("error"), str)
                        or not actual["error"]
                    ):
                        reasons.append("expected a nonempty error record")
                else:
                    if set(actual) != {"id", "task", "output"} or not isinstance(
                        actual.get("output"), str
                    ):
                        reasons.append("expected exact string output schema")
                    elif case["task"] == 1:
                        if actual["output"] not in expected["nearest"]:
                            reasons.append("output not in exact nearest-integer set")
                        if actual["output"] != expected["declared_output"]:
                            reasons.append("output violates declared tie rule")
                    elif actual["output"] != expected["output"]:
                        reasons.append("output differs from exact grouping oracle")
            outcomes.append(
                {
                    "id": case["id"],
                    "scope": case.get("scope"),
                    "expected": case["expected"],
                    "actual": actual,
                    "pass": not reasons,
                    "errors": reasons,
                }
            )
        with (output / "outcomes.jsonl").open(
            "w", encoding="ascii", newline="\n"
        ) as stream:
            for index, outcome in enumerate(outcomes):
                stream.write(encode(outcome) + "\n")
                if index % 128 == 0:
                    checkpoint("outcome_serialization")
        checkpoint("verification_complete")
        result["passed"] = sum(x["pass"] for x in outcomes)
        result["failed"] = len(outcomes) - result["passed"]
        if result["failed"]:
            result["errors"].append("one or more oracle checks failed")
        if not result["errors"]:
            result["status"] = "PASS"
    except BaseException as exc:
        result["status"] = "FAIL"
        result["errors"].append(f"{type(exc).__name__}: {exc}")
    finally:
        signal.setitimer(signal.ITIMER_REAL, 0)
        signal.signal(signal.SIGALRM, old_alarm)
        if proc is not None:
            live_before = group_members(proc.pid)
            result["owned_live_before_cleanup"] = live_before
            result["observed_owned_identities"] = list(known_identities.values())
            if live_before:
                if (
                    leader_identity is not None
                    and process_identity(proc.pid) == leader_identity
                ):
                    try:
                        os.killpg(proc.pid, signal.SIGKILL)
                    except ProcessLookupError:
                        pass
                else:
                    result["unknown_group_members_not_signalled"] = []
                    for pid in live_before:
                        identity = known_identities.get(pid)
                        if identity is not None and process_identity(pid) == identity:
                            try:
                                os.kill(pid, signal.SIGKILL)
                            except ProcessLookupError:
                                pass
                        else:
                            result["unknown_group_members_not_signalled"].append(pid)
                result["status"] = "FAIL"
                result["errors"].append("owned process group required cleanup")
            try:
                proc.wait(timeout=3)
            except subprocess.TimeoutExpired:
                result["errors"].append(
                    "native process did not reap within cleanup limit"
                )
            result["native_exit"] = proc.returncode
            result["owned_live_after_cleanup"] = group_members(proc.pid)
            if result["owned_live_after_cleanup"]:
                result["status"] = "FAIL"
                result["errors"].append("owned process remains after cleanup")
        end_self = resource.getrusage(resource.RUSAGE_SELF)
        end_child = resource.getrusage(resource.RUSAGE_CHILDREN)
        result["wall_seconds"] = time.monotonic() - start
        result["cpu_seconds"] = (
            end_self.ru_utime
            + end_self.ru_stime
            - start_self.ru_utime
            - start_self.ru_stime
        ) + (
            end_child.ru_utime
            + end_child.ru_stime
            - start_child.ru_utime
            - start_child.ru_stime
        )
        result["native_maxrss_kib"] = end_child.ru_maxrss
        result["supervisor_maxrss_kib"] = end_self.ru_maxrss
        result["final_source_pins"] = {path: digest(path) for path in manifest["files"]}
        if result["final_source_pins"] != manifest["files"]:
            result["errors"].append("source pins changed during qualification")
        if result["errors"]:
            result["status"] = "FAIL"
        result["output_hashes"] = {
            path.name: digest(path) for path in output.iterdir() if path.is_file()
        }
        (output / "RESULT.json").write_text(
            json.dumps(result, indent=2, sort_keys=True) + "\n"
        )
    print(
        encode(
            {
                "status": result["status"],
                "passed": result.get("passed", 0),
                "failed": result.get("failed"),
                "errors": result["errors"],
                "result": str(output / "RESULT.json"),
            }
        )
    )
    return 0 if result["status"] == "PASS" else 1


if __name__ == "__main__":
    sys.exit(main())
