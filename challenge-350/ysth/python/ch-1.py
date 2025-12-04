import re

# https://theweeklychallenge.org/blog/perl-weekly-challenge-350/#TASK1


# find overlapping 3 character substrings with 3 unique characters
def good_substrings(string: str) -> int:
    matches = len(re.findall(r"(?!(.).?\1|.(.)\2)(?=...)", string, re.DOTALL))

    return matches


if __name__ == "__main__":
    import run_weeklychallenge as run

    run.run_weekly_challenge(
        lambda inputs: str(good_substrings(str(inputs))),
        '"abcaefg"',
        '{"type":"string"}',
    )
