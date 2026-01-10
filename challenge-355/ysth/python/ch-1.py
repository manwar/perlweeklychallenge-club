import regex

# https://theweeklychallenge.org/blog/perl-weekly-challenge-355/#TASK1

def thousand_separator(i: int) -> str:
    return f'{i:,d}'

if __name__ == "__main__":
    import run_weeklychallenge as run

    run.run_weekly_challenge(
        lambda inputs: run.dumps(thousand_separator(run.cast(int, inputs))),
        '123',
        '{"type": "integer", "minimum": 1}',
    )
