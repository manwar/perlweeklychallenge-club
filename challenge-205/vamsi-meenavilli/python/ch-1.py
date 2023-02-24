import re
import unittest

"""
 Week 205:

	https://theweeklychallenge.org/blog/perl-weekly-challenge-205

	Task 1: Third Highest
	Submitted by: Mohammad S Anwar
	You are given an array of integers.

	Write a script to find out the Third Highest if found otherwise return the maximum.

	Example 1
	Input: @array = (5,3,4)
	Output: 3

	First highest is 5. Second highest is 4. Third highest is 3.
	Example 2
	Input: @array = (5,6)
	Output: 6

	First highest is 6. Second highest is 5. Third highest is missing, so maximum is returned.
	Example 3
	Input: @array = (5,4,4,3)
	Output: 3

	First highest is 5. Second highest is 4. Third highest is 3.
"""


class ThirdHighestOrMax:
	@staticmethod
	def third_highest_or_max(array: list[int]) -> int:
		sorted_array = sorted(list(set(array)), reverse=True)

		return sorted_array[2] if len(sorted_array) > 2 else sorted_array[0]


class ThirdHighestOrMaxTestCases(unittest.TestCase):
	def test_third_highest_or_max(self):
		self.assertEqual(3, ThirdHighestOrMax.third_highest_or_max([5,3,4]), 'Test case 1 Failed.')
		self.assertEqual(6, ThirdHighestOrMax.third_highest_or_max([5,6]), 'Test case 2 Failed.')
		self.assertEqual(3, ThirdHighestOrMax.third_highest_or_max([5,4,4,3]), 'Test case 3 Failed.')


if __name__ == '__main__':
	unittest.main()
