#!/usr/bin/env python

import sys

def is_binary_palandrome (integer):
	"""Takes an integer, converts it to the binary representation,
	returns 1 if binary representation is a palandrome and 0 if not"""
	binary = format(integer, 'b')
	if binary == binary[::-1]:
		return 1
	else:
		return 0

if __name__ == "__main__":
	print(is_binary_palandrome(4))
	print(is_binary_palandrome(5))
