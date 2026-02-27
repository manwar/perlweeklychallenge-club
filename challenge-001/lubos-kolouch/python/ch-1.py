#!/usr/bin/env python3

import unittest


def replace_e(what: str) -> tuple[int, str]:
    """Return count of 'e' and a copy with 'e' replaced by 'E'."""
    count = what.count("e")
    modified_what = what.replace("e", "E")
    return count, modified_what


class TestChallenge001Task1(unittest.TestCase):
    def test_example(self) -> None:
        self.assertEqual(
            replace_e("Perl Weekly Challenge"), (5, "PErl WEEkly ChallEngE")
        )


if __name__ == "__main__":
    unittest.main()
