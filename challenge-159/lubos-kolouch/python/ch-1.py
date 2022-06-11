""" Challenge 159 Task 1"""


def farey_sequence(n: int, descending: bool = False) -> str:
    """Print the n'th Farey sequence. Allow for either ascending or descending."""
    (a, b, c, d) = (0, 1, 1, n)

    solution = []
    if descending:
        (a, c) = (1, n - 1)
    solution.append(f"{a}/{b}")
    while (c <= n and not descending) or (a > 0 and descending):
        k = (n + b) // d
        (a, b, c, d) = (c, d, k * c - a, k * d - b)
        solution.append(f"{a}/{b}")

    return ", ".join(solution)


assert farey_sequence(5) == "0/1, 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4, 4/5, 1/1"
