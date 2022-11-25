"""
Week 192:

https://theweeklychallenge.org/blog/perl-weekly-challenge-192

Task 1: Equal Distribution
Submitted by: Mohammad S Anwar
You are given a list of integers greater than or equal to zero, @list.

Write a script to distribute the number so that each members are same. If you succeed then print the total moves otherwise print -1.

Please follow the rules (as suggested by Neils van Dijke [2022-11-21 13:00]

1) You can only move a value of '1' per move
2) You are only allowed to move a value of '1' to a direct neighbor/adjacent cell
"""


def equalDistributionMoves(numbers_list: list) -> int:
	numbers_list_size = len(numbers_list)
	moves = 0

	if sum(numbers_list) % numbers_list_size == 0:
		while len(set(numbers_list)) != 1:
			max_number_index = getMaxNumberIndex(numbers_list)
			before_max_number_index = max_number_index - 1
			after_max_number_index = max_number_index + 1

			if after_max_number_index >= numbers_list_size or numbers_list[before_max_number_index] <= numbers_list[
				after_max_number_index]:
				numbers_list[before_max_number_index] += 1
			else:
				numbers_list[after_max_number_index] += 1

			numbers_list[max_number_index] -= 1
			moves += 1
	else:
		moves = -1

	return moves


def getMaxNumberIndex(numbers_list: list) -> int:
	max_number = 0
	max_number_index = 0

	for index, number in enumerate(numbers_list):
		if number > max_number:
			max_number = number
			max_number_index = index

	return max_number_index


def equalDistributionMovesTest() -> None:
	assert equalDistributionMoves([1, 0, 5]) == 4, 'Example 1 Failed'
	assert equalDistributionMoves([0, 2, 0]) == -1, 'Example 2 Failed'
	assert equalDistributionMoves([0, 3, 0]) == 2, 'Example 3 Failed'


equalDistributionMovesTest()
