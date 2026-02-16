
import regex

# https://theweeklychallenge.org/blog/perl-weekly-challenge-360/#TASK2

def word_sorter(sentence: str) -> str:
    return " ".join(sorted(filter(lambda s:len(s)>0, sentence.split(" ")), key=str.lower))


if __name__ == "__main__":
    import run_weeklychallenge as run

    run.run_weekly_challenge(
        lambda inputs: run.dumps(word_sorter(run.cast(str, inputs))),
        '"The quick brown fox"',
        '{"type":"string"}',
    )
