from collections import defaultdict


def string_chain(arr):
    in_degree = defaultdict(int)
    out_degree = defaultdict(int)

    for s in arr:
        in_degree[s[0]] += 1
        out_degree[s[-1]] += 1

    return in_degree == out_degree


# Test
print(string_chain(["abc", "dea", "cd"]))  # Output: 1
