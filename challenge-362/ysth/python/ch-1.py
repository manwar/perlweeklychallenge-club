
# https://theweeklychallenge.org/blog/perl-weekly-challenge-362/#TASK1

def echo_chamber(string: str) -> str:
    return ''.join(character * (1+index) for index, character in enumerate(string))

if __name__ == "__main__":
    import run_weeklychallenge as run

    run.run_weekly_challenge_v2(
        run_solution = lambda inputs: echo_chamber(run.cast(str, inputs)),
        inputs_example = '"abca"',
        inputs_schema_json = '{"type":"string", "pattern":"^[^\\\\W\\\\d_]+$"}',
    )
