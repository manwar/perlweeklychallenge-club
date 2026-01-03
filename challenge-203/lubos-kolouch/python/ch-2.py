#!/usr/bin/env python3
"""Copy Directory - Perl Weekly Challenge 203 task 2."""

from __future__ import annotations

from collections.abc import Sequence
from pathlib import Path
import sys
import tempfile
import unittest


def copy_directory(source: Path, target: Path) -> None:
    """Recursively copy directory structure from source to target, excluding files."""
    if not source.is_dir():
        raise ValueError(f"Source is not a directory: {source}")
    target.mkdir(parents=True, exist_ok=True)

    for entry in source.iterdir():
        if not entry.is_dir():
            continue
        dest = target / entry.name
        dest.mkdir(parents=True, exist_ok=True)
        copy_directory(entry, dest)


class CopyDirectoryExamples(unittest.TestCase):
    """Example-based test derived from the specification's directory tree."""

    def test_example(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            tmp_path = Path(tmp)
            source = tmp_path / "a" / "b" / "c"
            target = tmp_path / "x" / "y"

            (source / "1").mkdir(parents=True)
            (source / "2").mkdir(parents=True)
            (source / "3").mkdir(parents=True)
            (source / "4").mkdir(parents=True)
            (source / "5").mkdir(parents=True)

            (source / "1" / "1.txt").write_text("x\n", encoding="utf-8")
            (source / "2" / "2.txt").write_text("x\n", encoding="utf-8")
            (source / "3" / "3.txt").write_text("x\n", encoding="utf-8")
            (source / "5" / "5.txt").write_text("x\n", encoding="utf-8")

            target.mkdir(parents=True)

            copy_directory(source, target)

            for d in ("1", "2", "3", "4", "5"):
                self.assertTrue((target / d).is_dir())

            self.assertFalse((target / "1" / "1.txt").exists())
            self.assertFalse((target / "2" / "2.txt").exists())
            self.assertFalse((target / "3" / "3.txt").exists())
            self.assertFalse((target / "5" / "5.txt").exists())


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    if len(args) != 2:
        raise SystemExit("Usage: python3 ch-2.py <source> <target>")
    source = Path(args[0])
    target = Path(args[1])
    copy_directory(source, target)
    print(f"Copied directories from {source} to {target}")


if __name__ == "__main__":
    main()

