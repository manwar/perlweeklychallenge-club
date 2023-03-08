#!/usr/bin/env python
# -*- coding: utf-8 -*-

from typing import List


def compute_h_index(citations: List[int]) -> int:
    """
    Computes the H-Index for a researcher given an array of their citations.

    The H-Index is the largest number h such that h articles have at least h citations each.

    Args:
        citations: A list of integers representing the citations of a researcher's publications.

    Returns:
        The H-Index of the researcher.

    Examples:
        >>> compute_h_index([10, 8, 5, 4, 3])
        4
        >>> compute_h_index([25, 8, 5, 3, 3])
        3
    """
    # Sort the citations in descending order
    citations = sorted(citations, reverse=True)

    # Find the largest h such that h articles have at least h citations each
    h_index = 0
    for i, citation in enumerate(citations):
        h = i + 1
        if citation >= h:
            h_index = h
        else:
            break

    return h_index


# Tests
def test_compute_h_index():
    assert compute_h_index([10, 8, 5, 4, 3]) == 4
    assert compute_h_index([25, 8, 5, 3, 3]) == 3


if __name__ == '__main__':
    test_compute_h_index()
