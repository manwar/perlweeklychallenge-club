
import re

# https://theweeklychallenge.org/blog/perl-weekly-challenge-364/#TASK1

def decrypt_string(string: str) -> str:
    return ''.join(chr(ord('a')+int(c)-1) for c in re.findall(r'1[0-9](?=#)|2[0-6](?=#)|[1-9]', string))

if __name__ == "__main__":
    import run_weeklychallenge as run

    run.run_weekly_challenge_v2(
        run_solution = lambda inputs: decrypt_string(run.cast(str, inputs)),
        inputs_example = '"10#11#12"',
        inputs_schema_json = '{"type":"string"}',
    )
