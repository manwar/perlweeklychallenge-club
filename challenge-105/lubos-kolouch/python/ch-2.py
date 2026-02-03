#!/usr/bin/env python3
"""
Perl Weekly Challenge 105 - Task 2: The Name Game

Given a name, output the lyrics to the Shirley Ellis song "The Name Game",
matching the official example.
"""

from __future__ import annotations

from typing import Sequence


def name_game_lyrics(name: str) -> str:
    """Return the 4-line lyrics block for the given name."""
    rest_of_name = name[1:]
    lines = [
        f"    {name}, {name}, bo-b{rest_of_name},",
        f"    Bonana-fanna fo-f{rest_of_name}",
        f"    Fee fi mo-m{rest_of_name}",
        f"    {name}!",
    ]
    return "\n".join(lines)

def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    if len(argv) != 1:
        raise SystemExit(f"Usage: {__file__} <name>")
    print(name_game_lyrics(argv[0]))


def _run_tests() -> None:
    import unittest

    class TestChallenge105Task2(unittest.TestCase):
        def test_example(self) -> None:
            self.assertEqual(
                name_game_lyrics("Katie"),
                "\n".join(
                    [
                        "    Katie, Katie, bo-batie,",
                        "    Bonana-fanna fo-fatie",
                        "    Fee fi mo-matie",
                        "    Katie!",
                    ]
                ),
            )

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge105Task2)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])
