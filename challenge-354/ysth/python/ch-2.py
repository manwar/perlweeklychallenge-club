from itertools import chain, batched
from typing import Any

# https://theweeklychallenge.org/blog/perl-weekly-challenge-354/#TASK2

# rotate matrix cells right by k
def shift_grid(matrix: list[list[Any]], k: int) -> list[list[Any]]:

    # can't shift what isn't there (no rows or no columns)
    if len(matrix) == 0 or len(matrix[0]) == 0:
        return matrix
    columns: int = len(matrix[0])

    for row in matrix:
        if len(row) != columns:
            raise Exception('matrix rows not all the same length')

    shift: int = k % (columns * len(matrix))
    cells = list(chain.from_iterable(matrix))
    shifted_cells = chain(cells[-shift:],cells[0:-shift])
    shifted_matrix: list[list[Any]] = list(list(row) for row in batched(shifted_cells, columns))

    return shifted_matrix

if __name__ == "__main__":
    import run_weeklychallenge as run

    run.run_weekly_challenge(
        lambda inputs: run.dumps(shift_grid(run.as_list_list(inputs, 'matrix'),run.as_int(inputs, 'k'))),
        '{"matrix":[[1, 2, 3], [4, 5, 6], [7, 8, 9]],"k":1}',
        '''{
            "type":"object",
            "properties": {
                "matrix": {"type": "array", "items": {"type": "array"}},
                "k": {"type": "integer", "minimum": 1}
            },
            "required":["matrix","k"],
            "additionalProperties": false
        }'''
    )
