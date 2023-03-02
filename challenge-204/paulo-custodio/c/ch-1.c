/*
Challenge 204

Task 1: Monotonic Array
Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to find out if the given array is Monotonic. Print 1 if it is otherwise 0.

    An array is Monotonic if it is either monotone increasing or decreasing.

Monotone increasing: for i <= j , nums[i] <= nums[j]
Monotone decreasing: for i <= j , nums[i] >= nums[j]


Example 1

Input: @nums = (1,2,2,3)
Output: 1

Example 2

Input: @nums = (1,3,2)
Output: 0

Example 3

Input: @nums = (6,5,5,4)
Output: 1
*/

#define MAX_DATA	1024

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

int is_monotonic(int size, int data[]) {
	if (size < 2)
		return 1;
	else {
		int climb = 0, descend = 0;
		for (int i = 0; i < size - 1; i++) {
			int delta = data[i+1]-data[i];
			if (delta > 0) climb++;
			else if (delta < 0) descend++;
			if (climb && descend) return 0;
		}
		return 1;
	}
}

int main(int argc, char* argv[]) {
	argv++; argc--;
	assert(argc <= MAX_DATA);
	int data[MAX_DATA];
	
	for (int i = 0; i < argc; i++)
		data[i] = atoi(argv[i]);
	printf("%d\n", is_monotonic(argc, data));
}
