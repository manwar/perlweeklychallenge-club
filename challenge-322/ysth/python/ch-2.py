import sys
import operator

integers = [int(value) for value in sys.argv[1:]]

# python doesn't have a clean dict slice syntax; usually a comprehension
# is used (e.g. (mydict[key] for key in mykeys)), but that evaluates the
# dict expression more than once, so use itemgetter or a map

print(
    " ".join(
        operator.itemgetter(*integers)(
            {
                value: str(i + 1)
                for i, value in enumerate(sorted(set(integers)))
            }
        )
    )
)
