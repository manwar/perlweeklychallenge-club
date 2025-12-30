import regex

# https://theweeklychallenge.org/blog/perl-weekly-challenge-354/#TASK1

# Given an array of distinct integers, return all pairs that have the minimum difference
def min_abs_diff(ints: list[int]) -> list[list[int]]:
    sorted_ints = sorted(ints)

    min_difference_pairs: list[list[int]] = list()
    if len(ints):
        min_difference: int = sorted_ints[-1] - sorted_ints[0] + 1
        for i in range(len(ints)-1):
            difference: int = sorted_ints[i+1] - sorted_ints[i]
            if difference <= min_difference:
                if difference < min_difference:
                    min_difference = difference
                    min_difference_pairs.clear()
                min_difference_pairs.append([sorted_ints[i], sorted_ints[i+1]])

    return min_difference_pairs

if __name__ == "__main__":
    import run_weeklychallenge as run
    from typing import cast

    run.run_weekly_challenge(
        lambda inputs: run.dumps(min_abs_diff(cast(list[int], inputs))),
        '[4, 2, 1, 3]',
        '{"type":"array", "items":{"type": "integer"}}',
    )
