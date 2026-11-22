#!/usr/bin/env python3

"""Simon's solution to task 2 of The Weekly Challenge"""

import sys

def is_next_gene(gene1: str, gene2: str):
    return 7 == sum(1 for i in range(8) if gene1[i] == gene2[i])

def mgm(start_gene: str, end_gene: str, gene_bank: list[str], used_genes: list[str]|None = None) -> int|None:
    first_call = False
    if used_genes is None:
        first_call = True
        # Check the start and end are in the pool
        if end_gene not in gene_bank:
            return -1
        used_genes = [ start_gene ]

    if used_genes[-1] == end_gene:
        return len(used_genes)-1

    min_count = None
    for gene in gene_bank:
        if gene in used_genes or not is_next_gene(used_genes[-1], gene):
            continue

        count = mgm(start_gene, end_gene, gene_bank, used_genes+[gene])
        if count and (min_count is None or min_count < count):
            min_count = count

    if min_count:
        return min_count

    return -1 if first_call else None


def main():
    """Convert command line input into parameters for the function and display result"""
    result = mgm(sys.argv[1], sys.argv[2], sys.argv[3:])
    print(result)


# Call main if run from the command line
if __name__ == "__main__":
    main()
