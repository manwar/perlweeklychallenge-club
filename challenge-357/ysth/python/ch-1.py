import regex

# https://theweeklychallenge.org/blog/perl-weekly-challenge-357/#TASK1

def kaprekar_constant(i: int) -> int:
    seen = {i}
    iterations = 0
    while i != 6174:
        digits: list[str] = list(f'{i:04}')
        digits.sort()
        i = int(''.join(digits[::-1])) - int(''.join(digits))
        if i in seen:
            return -1
        seen.add(i)
        iterations += 1
    return iterations

if __name__ == "__main__":
    import run_weeklychallenge as run

    run.run_weekly_challenge(
        lambda inputs: run.dumps(kaprekar_constant(run.cast(int, inputs))),
        '3524',
        '{"type": "integer", "minimum": 0, "maximum": 9999}',
    )
