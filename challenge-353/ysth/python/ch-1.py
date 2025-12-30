import regex

# https://theweeklychallenge.org/blog/perl-weekly-challenge-353/#TASK1

# Given an array of sentences, return the maximum number of words that appear in a single sentence.
def max_words(sentences: list[str]) -> int:
    # for our purposes here, a word is a group of non-space characters that includes a number or letter
    return max( len(regex.findall(r'\S*?[\p{L}\p{N}]\S*', sentence)) for sentence in sentences )

if __name__ == "__main__":
    import run_weeklychallenge as run
    from typing import cast

    run.run_weekly_challenge(
        lambda inputs: str(max_words(cast(list[str], inputs))),
        '["Hello world", "This is a test", "Perl is great"]',
        '{"type":"array", "items": {"type": "string"}}',
    )
