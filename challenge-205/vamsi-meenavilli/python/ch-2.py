import re
import unittest

"""
 Week 205:

	https://theweeklychallenge.org/blog/perl-weekly-challenge-205

	Task 2: Maximum XOR
	Submitted by: Mohammad S Anwar
	You are given an array of integers.

	Write a script to find the highest value obtained by XORing any two distinct members of the array.

	Example 1
	Input: @array = (1,2,3,4,5,6,7)
	Output: 7

	The maximum result of 1 xor 6 = 7.
	Example 2
	Input: @array = (2,4,1,3)
	Output: 7

	The maximum result of 4 xor 3 = 7.
	Example 3
	Input: @array = (10,5,7,12,8)
	Output: 15

	The maximum result of 10 xor 5 = 15.

"""


class MaximumXor:
	@staticmethod
	def maximum_xor(array: list[int]) -> int:
		array_length = len(array)
		max_xor = 0

		for i in range(array_length):
			for j in range(i + 1, array_length):
				temp_xor = array[i] ^ array[j]

				if temp_xor > max_xor:
					max_xor = temp_xor

		return max_xor


class MaximumXorTestCases(unittest.TestCase):
	def test_maximum_xor(self):
		self.assertEqual(7, MaximumXor.maximum_xor([1,2,3,4,5,6,7]), 'Test case 1 Failed.')
		self.assertEqual(7, MaximumXor.maximum_xor([2,4,1,3]), 'Test case 2 Failed.')
		self.assertEqual(15, MaximumXor.maximum_xor([10,5,7,12,8]), 'Test case 3 Failed.')


if __name__ == '__main__':
	unittest.main()
