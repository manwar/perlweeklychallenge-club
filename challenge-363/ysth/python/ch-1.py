
from word2number.w2n import word_to_num
import regex

# https://theweeklychallenge.org/blog/perl-weekly-challenge-363/#TASK1

def string_lie_detector(string: str) -> bool:
    m = regex.match(r'^(?P<string>.*)\s\p{Pd}\s(?P<vowels>.*)\svowels?\sand\s(?P<consonants>.*)\sconsonants?\Z', string)
    if m is None:
        return False
    vowel_set = set('aeiouAEIOU')
    consonant_set = set('bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ')
    vowel_count = 0
    consonant_count = 0
    for character in m['string']:
        if character in vowel_set:
            vowel_count += 1
        elif character in consonant_set:
            consonant_count += 1

    result = False
    try:
        result = word_to_num(m['vowels']) == vowel_count and word_to_num(m['consonants']) == consonant_count
    except:
        pass
    return result

if __name__ == "__main__":
    import run_weeklychallenge as run

    run.run_weekly_challenge_v2(
        run_solution = lambda inputs: string_lie_detector(run.cast(str, inputs)),
        inputs_example = '"aa \u2014 two vowels and zero consonants"',
        inputs_schema_json = '{"type":"string"}',
    )
