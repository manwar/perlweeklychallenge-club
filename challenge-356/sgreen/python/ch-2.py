#!/usr/bin/env python3

import re
import sys


def who_wins(results: str) -> str:
    """Determine the winner of the NFL playoffs based on match results.

    Args:
        results (str): A string of 6 characters representing match results. 'H' indicates the home team won, 'A' indicates the away team won.

    Returns:
        str: A string announcing the final winner, and who they played against.
    """
    if re.match(r"^[HA]{6}$", results) is None:
        raise ValueError(
            "Results string must be exactly 6 characters of 'H' or 'A'.")

    # Calculate week one winners, and teams playing in week two
    week_two = sorted([
        1,
        2 if results[0] == "H" else 7,
        3 if results[1] == "H" else 6,
        4 if results[2] == "H" else 5,
    ])

    # Calculate week two winners, and teams playing in week three
    week_three = sorted([
        week_two[0] if results[3] == "H" else week_two[3],
        week_two[1] if results[4] == "H" else week_two[2],
    ])

    if results[5] == "A":
        # The away team won, so we need to reverse the order
        week_three.reverse()

    return f"Team {week_three[0]} defeated Team {week_three[1]}"


def main():
    result = who_wins(sys.argv[1])
    print(result)


if __name__ == "__main__":
    main()
