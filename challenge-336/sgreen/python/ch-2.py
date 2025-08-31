#!/usr/bin/env python3

import re
import sys


def final_score(scores: list[str]) -> int:
    score_stack = []

    for score in scores:
        if score == "C":
            # Clear the previous score
            if not score_stack:
                raise ValueError("No scores to remove for 'C' operation")
            score_stack.pop()
        elif score == "D":
            # Double the previous score
            if not score_stack:
                raise ValueError("No scores to double for 'D' operation")
            score_stack.append(2 * score_stack[-1])
        elif score == "+":
            # Sum the previous two scores
            if len(score_stack) < 2:
                raise ValueError("Not enough scores to sum for '+' operation")
            score_stack.append(score_stack[-1] + score_stack[-2])
        elif re.match(r"^-?\d+$", score):
            # It's a valid integer score
            score_stack.append(int(score))
        else:
            # We don't know what score this is
            raise ValueError(f"Invalid score entry: {score}")

    return sum(score_stack)


def main():
    result = final_score(sys.argv[1:])
    print(result)


if __name__ == '__main__':
    main()
