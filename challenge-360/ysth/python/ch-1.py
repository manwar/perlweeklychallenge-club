
from unicode_width_approximation import get_string_width

# https://theweeklychallenge.org/blog/perl-weekly-challenge-360/#TASK1

def text_justifier(string: str, width: int) -> str:
    padding = width - get_string_width(string)
    if padding < 0:
        raise Exception('String does not fit within width')

    justified_string = '*' * int(padding/2) + string + '*' * int((padding + 1) / 2)
    return justified_string

if __name__ == "__main__":
    import run_weeklychallenge as run

    run.run_weekly_challenge_v2(
        run_solution = lambda inputs: text_justifier(run.as_str(inputs, 'str'), run.as_int(inputs, 'width')),
        inputs_example = '{"str": "Hi", "width":5}',
        inputs_schema_json = '''{
            "type": "object",
            "properties": {
                "str": {"type": "string"},
                "width": {"type": "integer", "minimum": 0}
            },
            "required": ["str", "width"],
            "additionalProperties": false
        }''',
    )
