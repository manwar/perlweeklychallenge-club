import re
import itertools

# https://theweeklychallenge.org/blog/perl-weekly-challenge-350/#TASK2


def shuffle_pairs(range_start: int, range_end: int, count: int) -> int:
    """
    Parameters:
    range_start/range_end: range of integers to inspect
    count: number of shuffle pairs

    Shuffle pairs are two numbers whose digits when sorted yield the same string and having one a multiple of the other by a factor called the witness.

    Returns the number of integers in the range that belong to at least the specified number of shuffle pairs
    """
    qualifying_integers: int = 0
    for i in range(range_start, range_end + 1):
        pairs: int = 0
        i_sorted: str = "".join(sorted(c for c in str(i)))
        i_length: int = len(i_sorted)

        # look for possible pairs with a higher or lower number
        j: str
        for j in itertools.chain(
            # maximum higher number can't have more digits
            (str(i * witness) for witness in range(2, 1 + (pow(10, i_length) - 1) // i)),
            # maximum witness can't be more than i's first digit
            (str(i / witness) for witness in range(2, 1 + int(str(i)[0]))),
        ):

            # is this a pair?
            if len(j) == i_length and i_sorted == "".join(sorted(c for c in j)):
                pairs += 1
                if pairs == count:
                    qualifying_integers += 1
                    break

    return qualifying_integers


if __name__ == "__main__":
    import run_weeklychallenge as run

    run.run_weekly_challenge(
        lambda inputs: str(
            shuffle_pairs(
                run.as_int(inputs, "from"),
                run.as_int(inputs, "to"),
                run.as_int(inputs, "count"),
            )
        ),
        '{"from":1,"to":1000,"count":1}',
        """{
            "type": "object",
            "properties": {
                "from": {"type": "integer", "minimum": 0},
                "to": {"type": "integer", "minimum": 0},
                "count": {"type": "integer"}
            },
            "required": ["from", "to", "count"],
            "additionalProperties": false
        }""",
    )
