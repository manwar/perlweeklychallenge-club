import re

# https://theweeklychallenge.org/blog/perl-weekly-challenge-359/#TASK1

def digital_root(i: int) -> tuple[int, int]:
    persistence = 0
    while i > 9:
        persistence += 1
        i = sum(int(digit) for digit in str(i))
    return (persistence, i)

if __name__ == "__main__":
    import run_weeklychallenge as run

    run.run_weekly_challenge(
        lambda inputs: run.dumps(digital_root(run.cast(int, inputs))),
        '38',
        '{"type": "integer", "minimum": 0}',
    )
