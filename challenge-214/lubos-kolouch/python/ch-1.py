#!/usr/bin/env python
# -*- coding: utf-8 -*-
from typing import List


def rank_scores(scores: List[int]) -> List[str]:
    sorted_scores = sorted(scores, reverse=True)
    ranks = {}
    rank = 1
    for i in range(len(sorted_scores)):
        if i > 0 and sorted_scores[i] == sorted_scores[i - 1]:
            ranks[sorted_scores[i]] = ranks[sorted_scores[i - 1]]
        else:
            ranks[sorted_scores[i]] = rank
        rank += 1
    output = []
    for score in scores:
        if ranks[score] == 1:
            output.append('G')
        elif ranks[score] == 2:
            output.append('S')
        elif ranks[score] == 3:
            output.append('B')
        else:
            output.append(str(ranks[score]))
    return output


scores = [1, 2, 4, 3, 5]
result = rank_scores(scores)
print(result)
