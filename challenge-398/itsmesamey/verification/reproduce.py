#!/usr/bin/env python3
"""Bind portable paths and run the retained Weekly Challenge 398 checks."""

import argparse
import hashlib
import json
import os
from pathlib import Path
import shutil

# The caller selects local tools; subprocess receives argv without a shell.
import subprocess  # nosec B404
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent


def digest(path):
    """Identify a source or retained result by its complete bytes."""
    return hashlib.sha256(path.read_bytes()).hexdigest()


def write_json(path, value):
    """Write a readable deterministic receipt."""
    path.write_text(json.dumps(value, indent=2, sort_keys=True) + "\n")


def main():
    """Generate local manifests for the batch and CLI runners."""
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--perl", default=shutil.which("perl"))
    parser.add_argument("--cpu", type=int)
    args = parser.parse_args()
    if sys.platform != "linux" or not Path("/proc/self/status").is_file():
        parser.error("The retained process-monitoring runners require Linux /proc")
    if not args.perl:
        parser.error("Perl must be installed; pass --perl if it is not on PATH")
    perl = Path(args.perl).resolve()
    if not perl.is_file():
        parser.error("Perl executable path does not exist")
    allowed = os.sched_getaffinity(0)
    cpu = min(allowed) if args.cpu is None else args.cpu
    if cpu not in allowed:
        parser.error("Selected CPU is outside the current allowed affinity")
    package_manifest = json.loads((ROOT / "PACKAGE_MANIFEST.json").read_text())
    for relative, expected in package_manifest.items():
        if digest(ROOT / relative) != expected:
            raise SystemExit("Package identity differs: " + relative)
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    candidate = ROOT / "perl"
    batch_runner = HERE / "run_native.py"
    cli_runner = HERE / "run_cli.py"
    oracle = HERE / "oracle.py"
    adapter = HERE / "batch.pl"
    batch_sources = [
        batch_runner,
        oracle,
        adapter,
        perl,
        candidate / "ch-1.pl",
        candidate / "ch-2.pl",
    ]
    batch_manifest = {
        "files": {str(path): digest(path) for path in batch_sources},
        "oracle": str(oracle),
        "adapter": str(adapter),
        "perl": str(perl),
        "candidate_dir": str(candidate),
        "case_count": 13146,
    }
    batch_manifest_path = output / "batch-manifest.json"
    write_json(batch_manifest_path, batch_manifest)
    commands = [
        [
            sys.executable,
            "-I",
            "-S",
            "-B",
            str(batch_runner),
            "--manifest",
            str(batch_manifest_path),
            "--output",
            str(output / "batch"),
            "--cpu",
            str(cpu),
            "--wall-seconds",
            "60",
            "--rss-mib",
            "256",
        ]
    ]
    receipt = {
        "status": "FAIL",
        "package_manifest_sha256": digest(ROOT / "PACKAGE_MANIFEST.json"),
        "commands": commands,
        "checks": {},
    }
    try:
        with (
            (output / "batch-driver.stdout").open("xb") as stdout,
            (output / "batch-driver.stderr").open("xb") as stderr,
        ):
            # The current Python runs a package-pinned local runner, without a shell.
            batch = subprocess.run(  # nosec B603
                commands[0], stdout=stdout, stderr=stderr, check=False
            )
        receipt["batch_driver_exit"] = batch.returncode
        batch_result_path = output / "batch/RESULT.json"
        if batch_result_path.exists():
            receipt["checks"]["batch_result_sha256"] = digest(batch_result_path)
        if batch.returncode != 0:
            return 1
        batch_result = json.loads(batch_result_path.read_text())
        if batch_result.get("status") != "PASS" or batch_result.get("passed") != 13146:
            raise ValueError("Batch did not establish all 13,146 expected outcomes")
        selection = json.loads((HERE / "CLI_SELECTION.json").read_text())
        cases = output / "batch/cases.jsonl"
        cli_sources = [
            cli_runner,
            batch_runner,
            cases,
            perl,
            candidate / "ch-1.pl",
            candidate / "ch-2.pl",
        ]
        cli_manifest = {
            "files": {str(path): digest(path) for path in cli_sources},
            "helpers": str(batch_runner),
            "oracle_cases": str(cases),
            "perl": str(perl),
            "candidate_dir": str(candidate),
            **selection,
        }
        cli_manifest_path = output / "cli-manifest.json"
        write_json(cli_manifest_path, cli_manifest)
        commands.append(
            [
                sys.executable,
                "-I",
                "-S",
                "-B",
                str(cli_runner),
                "--manifest",
                str(cli_manifest_path),
                "--output",
                str(output / "cli"),
                "--cpu",
                str(cpu),
            ]
        )
        with (
            (output / "cli-driver.stdout").open("xb") as stdout,
            (output / "cli-driver.stderr").open("xb") as stderr,
        ):
            # The current Python runs the package-pinned CLI runner, without a shell.
            cli = subprocess.run(  # nosec B603
                commands[1], stdout=stdout, stderr=stderr, check=False
            )
        receipt["cli_driver_exit"] = cli.returncode
        cli_result_path = output / "cli/RESULT.json"
        if cli_result_path.exists():
            receipt["checks"]["cli_result_sha256"] = digest(cli_result_path)
        if cli.returncode != 0:
            return 1
        cli_result = json.loads(cli_result_path.read_text())
        if cli_result.get("status") != "PASS" or cli_result.get("passed") != 13:
            raise ValueError("CLI check did not establish all 13 expected outcomes")
        for relative, expected in package_manifest.items():
            if digest(ROOT / relative) != expected:
                raise ValueError("Package changed during checks: " + relative)
        receipt["status"] = "PASS"
        receipt["batch_passed"] = 13146
        receipt["cli_passed"] = 13
        return 0
    except (OSError, ValueError) as error:
        receipt["error"] = type(error).__name__ + ": " + str(error)
        return 1
    finally:
        write_json(output / "REPRODUCTION.json", receipt)
        print(
            json.dumps(
                {
                    "status": receipt["status"],
                    "receipt": str(output / "REPRODUCTION.json"),
                }
            )
        )


if __name__ == "__main__":
    raise SystemExit(main())
