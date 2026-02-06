#!/usr/bin/env python3
"""
Perl Weekly Challenge 103 - Task 2: What's playing?

Given:
  - start time (Unix epoch seconds) of the streamer
  - current time (Unix epoch seconds)
  - a CSV file where each line is: milliseconds,title

Assuming gapless looping playback, determine which track is currently playing
and the current position within the track.
"""

from __future__ import annotations

import csv
from dataclasses import dataclass
from pathlib import Path
from typing import List, Sequence, Tuple


@dataclass(frozen=True)
class Track:
    length_ms: int
    title: str


def _read_tracks(csv_path: Path) -> List[Track]:
    tracks: List[Track] = []
    with csv_path.open(newline="", encoding="utf-8") as f:
        reader = csv.reader(f)
        for row in reader:
            if not row:
                continue
            length_ms = int(row[0])
            title = row[1]
            tracks.append(Track(length_ms=length_ms, title=title))
    if not tracks:
        raise ValueError("empty track list")
    return tracks


def _format_hms(seconds: int) -> str:
    h = seconds // 3600
    m = (seconds % 3600) // 60
    s = seconds % 60
    return f"{h:02d}:{m:02d}:{s:02d}"


def now_playing(start_time: int, current_time: int, csv_path: Path) -> Tuple[str, str]:
    """
    Return (title, position_hhmmss) for the currently playing track.
    """
    if current_time < start_time:
        raise ValueError("current_time must be >= start_time")

    tracks = _read_tracks(csv_path)
    total_ms = sum(t.length_ms for t in tracks)
    elapsed_ms = (current_time - start_time) * 1000
    offset_ms = elapsed_ms % total_ms

    acc = 0
    for t in tracks:
        if acc + t.length_ms > offset_ms:
            pos_ms = offset_ms - acc
            return t.title, _format_hms(pos_ms // 1000)
        acc += t.length_ms

    raise RuntimeError("unreachable")


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    if len(argv) != 3:
        raise SystemExit(f"Usage: {__file__} <start_time> <current_time> <filelist.csv>")

    start_time = int(argv[0])
    current_time = int(argv[1])
    csv_path = Path(argv[2])
    title, pos = now_playing(start_time, current_time, csv_path)
    print(title)
    print(pos)


def _run_tests() -> None:
    import unittest

    class TestChallenge103Task2(unittest.TestCase):
        def test_example(self) -> None:
            csv_path = Path(__file__).resolve().parents[1] / "perl" / "now_playing.csv"
            title, pos = now_playing(1606134123, 1614591276, csv_path)
            self.assertEqual(
                title,
                "Les Miserables Episode 1: The Bishop (broadcast date: 1937-07-23)",
            )
            self.assertEqual(pos, "00:10:24")

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge103Task2)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

