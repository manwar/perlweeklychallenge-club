
import re

# https://theweeklychallenge.org/blog/perl-weekly-challenge-364/#TASK2

def goal_parser(string: str) -> str:
    return re.sub(r'(G|\(\)|\(al\))|[^G(]+|.', lambda m: ['G','o','','al'][2 if m.group(1) is None else len(m.group(1))-1], string)

if __name__ == "__main__":
    import run_weeklychallenge as run

    run.run_weekly_challenge_v2(
        run_solution = lambda inputs: goal_parser(run.cast(str, inputs)),
        inputs_example = '"G()(al)"',
        inputs_schema_json = '{"type":"string"}',
    )
