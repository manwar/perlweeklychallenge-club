import re

# https://theweeklychallenge.org/blog/perl-weekly-challenge-358/#TASK1

def max_str_value(strings: list[str]) -> int:
    return max(int(s) if re.fullmatch(r'^[0-9]+\z', s) else len(s) for s in strings)

if __name__ == "__main__":
    import run_weeklychallenge as run

    run.run_weekly_challenge(
        lambda inputs: run.dumps(max_str_value(run.cast(list[str], inputs))),
        '["123", "45", "6"]',
        '{"type": "array", "items": {"type": "string"}}',
    )
