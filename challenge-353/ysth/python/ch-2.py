import regex
from typing import cast

# https://theweeklychallenge.org/blog/perl-weekly-challenge-353/#TASK2

def validate_coupon(codes: list[str], names: list[str], status: list[str]) -> list[bool]:
    if len(codes) != len(names) or len(codes) != len(status):
        raise Exception('Arrays not all of the same length')
    valid_names: set[str] = { 'electronics', 'grocery', 'pharmacy', 'restaurant' }

    return [ regex.fullmatch(r'\w+', codes[i], regex.ASCII) is not None and names[i] in valid_names and status[i] == 'true' for i in range(len(codes)) ]

if __name__ == "__main__":
    import run_weeklychallenge as run
    import json

    run.run_weekly_challenge(
        lambda inputs: json.dumps(validate_coupon(run.as_str_list(inputs, 'codes'),run.as_str_list(inputs, 'names'),run.as_str_list(inputs, 'status')), separators=(',',':')),
        '{"codes": ["A123", "B_456", "C789", "D@1", "E123"], "names": ["electronics", "restaurant", "electronics", "pharmacy", "grocery"], "status": ["true", "false", "true", "true", "true"]}',
        '''{
            "type":"object",
            "properties": {
                "codes": { "type": "array", "items": { "type": "string" } },
                "names": { "type": "array", "items": { "type": "string" } },
                "status": { "type": "array", "items": { "type": "string" } }
            },
            "required": ["codes","names","status"],
            "additionalProperties": false
        }'''
    )
