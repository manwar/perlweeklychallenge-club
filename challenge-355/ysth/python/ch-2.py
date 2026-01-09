
# https://theweeklychallenge.org/blog/perl-weekly-challenge-355/#TASK2

def _cmp(a: int, b: int) -> int:
    return int(b < a) - int(a < b)

# true if integers in ints monotonically increase then decrease
def mountain_array(ints: list[int]) -> bool:
    length: int = len(ints)
    if length < 3 or ints[0] >= ints[1] or ints[-2] <= ints[-1]:
        return False

    direction: int = 1
    i: int = length - 1
    while (i := i - 1) > 1:
        if direction != (new_direction := _cmp(ints[i-1], ints[i])):
            if direction == 1 and new_direction == -1:
                direction = -1
            else:
                return False
    return True

if __name__ == "__main__":
    import run_weeklychallenge as run

    run.run_weekly_challenge(
        lambda inputs: run.dumps(mountain_array(run.cast(list[int], inputs))),
        '[1, 2, 3, 4, 5]',
        '{"type":"array", "items": {"type": "integer"}}',
    )
