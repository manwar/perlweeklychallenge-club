
# https://theweeklychallenge.org/blog/perl-weekly-challenge-358/#TASK2

def encrypted_string(string: str, shift: int) -> str:
    return string.translate({a+i: a+(shift+i)%26 for i in range(26) for a in (ord('a'),ord('A'))})

if __name__ == "__main__":
    import run_weeklychallenge as run

    run.run_weekly_challenge(
        lambda inputs: run.dumps(encrypted_string(run.as_str(inputs, 'str'), run.as_int(inputs, 'int'))),
        '{"str": "abc", "int": 1}',
        '''{
            "type":"object",
            "properties": {
                "str": {"type": "string"},
                "int": {"type": "integer"}
            },
            "required":["str","int"],
            "additionalProperties": false
        }''',
    )
