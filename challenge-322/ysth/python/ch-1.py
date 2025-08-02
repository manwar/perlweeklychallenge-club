import itertools
import sys

string = sys.argv[1]
group_size = int(sys.argv[2])

print(
    "-".join(
        reversed(
            [
                "".join(reversed(group))
                for group in itertools.batched(
                    reversed(string.replace("-", "")), group_size
                )
            ]
        )
    )
)
