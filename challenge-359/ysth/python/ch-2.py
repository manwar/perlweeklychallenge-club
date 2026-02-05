
import regex

# https://theweeklychallenge.org/blog/perl-weekly-challenge-359/#TASK2

def string_reduction(word: str) -> str:
    return regex.sub(r'(.)(?R)*?\1', '', word)

if __name__ == "__main__":
    import run_weeklychallenge as run

    run.run_weekly_challenge(
        lambda inputs: run.dumps(string_reduction(run.cast(str, inputs))),
        '"aabbccdd"',
        '{"type":"string"}',
    )
