#!/usr/bin/env python
# -*- coding: utf-8 -*-

#!/usr/bin/env python3


def standard_ranking(scores):
    sorted_scores = sorted(scores, reverse=True)
    ranks = [sorted_scores.index(score) + 1 for score in scores]
    return ranks


def modified_ranking(scores):
    sorted_scores = sorted(scores, reverse=True)
    ranks = []
    rank = 1
    for score in sorted_scores:
        if score not in ranks:
            rank = sorted_scores.index(score) + 1
        ranks.append(rank)
    return [ranks[sorted_scores.index(score)] for score in scores]


def dense_ranking(scores):
    sorted_scores = sorted(scores, reverse=True)
    ranks = [1]
    for i in range(1, len(sorted_scores)):
        if sorted_scores[i] == sorted_scores[i - 1]:
            ranks.append(ranks[i - 1])
        else:
            ranks.append(ranks[i - 1] + 1)
    return [ranks[sorted_scores.index(score)] for score in scores]


# Test the functions
scores = [10, 20, 30, 20, 40, 50, 10, 30]
print("Scores: ", scores)

standard_ranks = standard_ranking(scores)
print("Standard Ranking: ", standard_ranks)

modified_ranks = modified_ranking(scores)
print("Modified Ranking: ", modified_ranks)

dense_ranks = dense_ranking(scores)
print("Dense Ranking: ", dense_ranks)
