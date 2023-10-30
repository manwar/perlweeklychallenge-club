#!/usr/bin/env python

def findTriplets(ints):
    solutions = []
    for i in range(0, len(ints) - 3 ):
        for j in range(i + 1, len(ints) - 2):
            for k in range(j + 1, len(ints) - 1):
                if (ints[i] != ints[j] and
                    ints[j] != ints[k] and
                    ints[i] != ints[k]):
                    solutions.append([i, j, k])
    return solutions

def solution(ints):
    intlist = ", ".join([ str(i) for i in ints ])
    print(f'Input: @ints = ({intlist})')
    solutions = findTriplets(ints)
    print(f'Output: {len(solutions)}')
    if solutions:
        print("")
        for triplet in solutions:
            i, j, k = triplet
            print(
                f"({i}, {j}, {k}) because " +
                f"{ints[i]} != {ints[j]} != {ints[k]}"
            )

print("Example 1:")
solution([4, 4, 2, 4, 3])

print("\nExample 2:")
solution([1, 1, 1, 1, 1])

print("\nExample 3:")
solution([4, 7, 1, 10, 7, 4, 1, 1])