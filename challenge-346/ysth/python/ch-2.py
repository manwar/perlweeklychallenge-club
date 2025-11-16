import run_weeklychallenge as run
import itertools
import re
 
def format_phone_number(phone_number: str) -> str:
    formatted_phone_number = re.sub(
        r'(.)-(.)\Z',
        r'-\1\2',
        '-'.join(
            ''.join(group) for group in itertools.batched(
                re.sub(r'[^0-9]', '', phone_number),
                3
            )
        )
    )
    return formatted_phone_number

def main() -> None:
    def run_solution(inputs: object) -> object:
        return format_phone_number(str(inputs))

    input_schema_json = '''{
        "type": "string"
    }'''

    input_example = '"12 345-6789"'

    run.run_weekly_challenge(run_solution, input_example, input_schema_json)

if __name__ == '__main__':
    main()
