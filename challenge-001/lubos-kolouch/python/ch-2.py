#!/usr/bin/env python3

import unittest


def fizz_buzz() -> list[int | str]:
    """Return classic FizzBuzz values from 1 to 20."""
    output = []
    for i in range(1, 21):
        line = ""
        if i % 3 == 0:
            line = "fizz"
        if i % 5 == 0:
            line += "buzz"
        if not line:
            line = i
        output.append(line)
    return output


class TestChallenge001Task2(unittest.TestCase):
    def test_example(self) -> None:
        self.assertEqual(
            fizz_buzz(),
            [
                1,
                2,
                "fizz",
                4,
                "buzz",
                "fizz",
                7,
                8,
                "fizz",
                "buzz",
                11,
                "fizz",
                13,
                14,
                "fizzbuzz",
                16,
                17,
                "fizz",
                19,
                "buzz",
            ],
        )


if __name__ == "__main__":
    unittest.main()
