import run_weeklychallenge as run
import datetime
import humanize
import locale
from typing import Dict
 
locale.setlocale(locale.LC_TIME, 'en_US.utf8')
humanize.activate('en_US')

mon: Dict[str, int] = { datetime.date(datetime.MINYEAR,m,1).strftime('%b'): m for m in range(1,13) }
day: Dict[str, int] = { humanize.ordinal(d): d for d in range(1,32) }

def format_date(date_string: str) -> str:
    date_parts = date_string.split(' ')
    if len(date_parts) != 3:
        raise Exception("invalid date format")
    d = day.get(date_parts[0])
    if not d:
        raise Exception("invalid day in date")
    m = mon.get(date_parts[1])
    if not m:
        raise Exception("invalid month in date")
    try:
        y = int(date_parts[2])
    except ValueError:
        raise Exception("invalid year in date")
    if y < 1900 or y > 2100:
        raise Exception("year out of range in date")

    formatted_date = f'{y:04}-{m:02}-{d:02}'

    return formatted_date

def main() -> None:
    def run_solution(inputs: object) -> object:
        return format_date(str(inputs))

    input_schema_json = '''{
        "type": "string"
    }'''

    input_example = '"10th Nov 2025"'

    run.run_weekly_challenge(run_solution, input_example, input_schema_json)

if __name__ == '__main__':
    main()
