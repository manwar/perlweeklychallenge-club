
import num2words

# https://theweeklychallenge.org/blog/perl-weekly-challenge-362/#TASK2

def spellbound_sorting(integers: list[int]) -> list[int]:
    return sorted(integers, key=num2words.num2words)

if __name__ == "__main__":
    import run_weeklychallenge as run

    run.run_weekly_challenge_v2(
        run_solution = lambda inputs: spellbound_sorting(run.cast(list[int], inputs)),
        inputs_example = '[6, 7, 8, 9, 10]',
        inputs_schema_json = '{"type":"array", "items": {"type":"integer"}}',
    )
