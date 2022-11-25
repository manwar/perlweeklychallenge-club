"""
 Week 192:

	https://theweeklychallenge.org/blog/perl-weekly-challenge-192

	Task 1: Binary Flip
	You are given a positive integer, $n.
	Write a script to find the binary flip.
"""

binaryNumberFlipMap = {'0': '1', '1': '0'}


def getBinarFlip(number):
	return int(''.join([binaryNumberFlipMap[i] for i in bin(number)[2:]]), 2)


def getBinarFlipTest():
	assert getBinarFlip(5) == 2, 'Exaple 1 Failed'
	assert getBinarFlip(4) == 3, 'Exaple 1 Failed'
	assert getBinarFlip(6) == 1, 'Exaple 1 Failed'

getBinarFlipTest()
