import sys

integers = [int(value) for value in sys.argv[1:]]

print(
    " ".join(
        list(
            map(
                {
                    value: str(i + 1)
                    for i, value in enumerate(sorted(set(integers)))
                }.__getitem__,
                integers,
            )
        )
    )
)
