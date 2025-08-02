#!/usr/bin/env python

def weakestRows(matrix):
    oneCount = [ sum(row) for row in matrix ]
    # sort the rows by their oneCount values
    # use the Decorate-Sort-Undecorate idiom
    # to convert the dict into a list
    # https://docs.python.org/3/howto/sorting.html#decorate-sort-undecorate
    decorated = [
        (oneCount[i], i) for i in range(len(oneCount))
    ]
    sorted_tuples = sorted(
        decorated,
        # the - before the first element sorts descending
        key=lambda k: (k[0], k[1])
    )
    weakest = [ t[1] for t in sorted_tuples ]
    return weakest

def comma_join(arr):
    return ', '.join(map(lambda i: str(i), arr))

def formatMatrix(matrix, indent=17):
    output = []
    for row in matrix:
        output_row = ' ' * indent + '  ['
        output_row += ', '.join(map(lambda i: str(i), row))
        output_row += ']'
        output.append(output_row)

    return(
        "[\n" + ",\n".join(output) + "\n" +
        ' ' * indent + ']'
    )

def solution(matrix):
    print(f'Input: $matrix = {formatMatrix(matrix)}')
    output = weakestRows(matrix)
    print(f'Output: ({comma_join(output)})')

print('Example 1:')
solution([
           [1, 1, 0, 0, 0],
           [1, 1, 1, 1, 0],
           [1, 0, 0, 0, 0],
           [1, 1, 0, 0, 0],
           [1, 1, 1, 1, 1]
         ])

print('\nExample 2:')
solution([
           [1, 0, 0, 0],
           [1, 1, 1, 1],
           [1, 0, 0, 0],
           [1, 0, 0, 0]
         ])