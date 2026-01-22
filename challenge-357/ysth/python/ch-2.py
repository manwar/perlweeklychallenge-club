
# https://theweeklychallenge.org/blog/perl-weekly-challenge-357/#TASK2

from fractions import Fraction

def unique_fraction_generator(i: int) -> list[str]:
    return [ f'{fraction.numerator}/{fraction.denominator}' for fraction in sorted(set(Fraction(numerator, denominator) for numerator in range(1,i+1) for denominator in range(1,i+1))) ]

if __name__ == "__main__":
    import run_weeklychallenge as run

    run.run_weekly_challenge(
        lambda inputs: run.dumps(unique_fraction_generator(run.cast(int, inputs))),
        '3',
        '{"type":"integer", "minimum":1}',
    )
