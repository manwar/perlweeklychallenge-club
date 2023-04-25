#!/usr/bin/env python
# -*- coding: utf-8 -*-


def max_score(numbers):

    def helper(numbers, memo):
        if not numbers:
            return 0

        key = tuple(numbers)
        if key in memo:
            return memo[key]

        max_score = 0
        i = 0
        while i < len(numbers):
            j = i
            while j < len(numbers) and numbers[j] == numbers[i]:
                j += 1

            length = j - i
            next_numbers = numbers[:i] + numbers[j:]
            score = length * length + helper(next_numbers, memo)
            max_score = max(max_score, score)
            i = j

        memo[key] = max_score
        return max_score

    return helper(numbers, {})


# Test cases
numbers1 = [2, 4, 3, 3, 3, 4, 5, 4, 2]
numbers2 = [1, 2, 2, 2, 2, 1]
numbers3 = [1]
numbers4 = [2, 2, 2, 1, 1, 2, 2, 2]

print(max_score(numbers1))  # Output: 23
print(max_score(numbers2))  # Output: 20
print(max_score(numbers3))  # Output: 1
print(max_score(numbers4))  # Output: 40
