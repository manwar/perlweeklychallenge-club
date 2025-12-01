import re

# https://theweeklychallenge.org/blog/perl-weekly-challenge-349/#TASK1

# find length of longest character repetition
def power_of_string(string: str) -> int:
    longest = max(len(m[0]) for m in re.findall(r'((.)\2*)', string, re.DOTALL))

    return longest 

if __name__ == '__main__':
    import run_weeklychallenge as run
    run.run_weekly_challenge(lambda inputs: str(power_of_string(str(inputs))), '"textbook"', '{"type":"string","minLength":1}')
