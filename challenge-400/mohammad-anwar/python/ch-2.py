#!/usr/bin/env python3

from collections import deque

def min_mutation(start, end, *bank):
    if start == end:
        return 0

    bank_set = {gene: True for gene in bank}
    if end not in bank_set:
        return -1

    queue = deque([[start, 0]])
    visited = {start: True}

    while queue:
        curr, steps = queue.popleft()
        if curr == end:
            return steps

        for i in range(len(curr)):
            orig = curr[i]
            for c in ['A', 'C', 'G', 'T']:
                if c == orig:
                    continue
                next_gene = curr[:i] + c + curr[i+1:]

                if next_gene in bank_set and not visited.get(next_gene):
                    visited[next_gene] = True
                    queue.append([next_gene, steps + 1])

    return -1

examples = [
    {
        "in": ["AACCGGTT","AACCGGTA",
               "AACCGCTA","AAACGGTA"],
        "out": -1,
    },
    {
        "in": ["AACCGGTT","AACCGGAA",
               "AACCGGTA","AACCGGAA","AACCGCTA","AACCCTAA","AACCGTAA"],
        "out": 2,
    },
    {
        "in": ["AAAAAAAA","AAAAACCC",
               "CAAAAAAA","CCAAAAAA","AAAAAAAC"],
        "out": -1,
    },
    {
        "in": ["GAAAAAAA","GCCCCCCC",
               "GCAAAAAA","GCCAAAAA","GCCCAAAA","GCCCCAAA","GCCCCCAA","GCCCCCCA","GCCCCCCC"],
        "out": 7,
    },
    {
        "in": ["AACCGGTT","AACCGGTT",
               "AACCGGTA"],
        "out": 0,
    },
]

for ex in examples:
    assert min_mutation(*ex["in"]) == ex["out"], f"Failed for input {ex['in']}"

print("All tests passed!")
