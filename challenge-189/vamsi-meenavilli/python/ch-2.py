#!/usr/bin/env python3

'''
Week 189:
	https://theweeklychallenge.org/blog/perl-weekly-challenge-189

Task #2: Array Degree
	You are given an array of 2 or more non-negative integers.
	Write a script to find out the smallest slice, i.e. contiguous subarray of the original array, having the degree of the given array.
	The degree of an array is the maximum frequency of an element in the array.

'''

import sys


def test__GetSmallestSliceOfArrayDegree():
	assert _GetSmallestSliceOfArrayDegree([1, 3, 3, 2]) == [3, 3], 'Example 1 Failed'
	assert _GetSmallestSliceOfArrayDegree([1, 2, 1, 3]) == [1, 2, 1], 'Example 2 Failed'
	assert _GetSmallestSliceOfArrayDegree([1, 3, 2, 1, 2]) == [2, 1, 2], 'Example 3 Failed'
	assert _GetSmallestSliceOfArrayDegree([1, 1, 2, 3, 2]) == [1, 1], 'Example 4 Failed'
	assert _GetSmallestSliceOfArrayDegree([2, 1, 2, 1, 1]) == [1, 2, 1, 1], 'Example 5 Failed'

	return

def _GetSmallestSliceOfArrayDegree(array):
	degree_of_array = _GetDegreeOfArray(array)

	if degree_of_array == 1:
		return min(array)

	array_size = len(array)
	degree_slices_sum_map = {}

	for i in range(array_size):
		array_slice = [array[i]]

		for j in range(i + 1, array_size):
			array_slice.append(array[j])

			if _GetDegreeOfArray(array_slice) == degree_of_array:
				degree_slices_sum_map[sum(array_slice)] = array_slice
				break

	return degree_slices_sum_map[sorted(degree_slices_sum_map.keys())[0]]

def _GetDegreeOfArray(array):
	degree = 0

	for i in set(array):
		element_degree = array.count(i)

		if element_degree > degree:
			degree = element_degree

	return degree

test__GetSmallestSliceOfArrayDegree()
