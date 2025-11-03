"""Magic Expression Challenge Solution.

Insert binary operators between the digits of a string so that the resulting
expression evaluates to a target integer.
"""

from __future__ import annotations

import unittest


def magic_expression(digits: str, target: int) -> list[str]:
    """Return sorted expressions that evaluate to ``target``.

    The function performs a depth-first search over every partition of the
    digit string, appending each operator while maintaining the cumulative
    value and most recent operand. Multiplication adjusts the running total
    to honour standard operator precedence without relying on ``eval``.
    """
    if not digits.isdigit():
        msg = "Input must consist solely of decimal digits."
        raise ValueError(msg)

    results: list[str] = []
    length = len(digits)

    def backtrack(index: int, expression: str, value: int,
                  last_operand: int) -> None:
        if index == length:
            if value == target:
                results.append(expression)
            return

        for end in range(index + 1, length + 1):
            chunk = digits[index:end]
            if len(chunk) > 1 and chunk[0] == "0":
                break
            number = int(chunk)

            if index == 0:
                backtrack(end, chunk, number, number)
                continue

            backtrack(end, f"{expression}+{chunk}", value + number, number)
            backtrack(end, f"{expression}-{chunk}", value - number, -number)
            product = last_operand * number
            backtrack(
                end,
                f"{expression}*{chunk}",
                value - last_operand + product,
                product,
            )

    backtrack(0, "", 0, 0)
    results.sort()
    return results


class MagicExpressionTests(unittest.TestCase):
    """Unit tests restricted to the specification examples."""

    def test_example_1(self) -> None:
        self.assertEqual(magic_expression("123", 6), ["1*2*3", "1+2+3"])

    def test_example_2(self) -> None:
        self.assertEqual(magic_expression("105", 5), ["1*0+5", "10-5"])

    def test_example_3(self) -> None:
        self.assertEqual(magic_expression("232", 8), ["2*3+2", "2+3*2"])

    def test_example_4(self) -> None:
        self.assertEqual(magic_expression("1234", 10), ["1*2*3+4", "1+2+3+4"])

    def test_example_5(self) -> None:
        self.assertEqual(
            magic_expression("1001", 2),
            [
                "1+0*0+1",
                "1+0+0+1",
                "1+0-0+1",
                "1-0*0+1",
                "1-0+0+1",
                "1-0-0+1",
            ],
        )


if __name__ == "__main__":
    unittest.main()
