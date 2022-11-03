#!/usr/bin/env python3

'''
Week 189:
	https://theweeklychallenge.org/blog/perl-weekly-challenge-189

Task #1: Greater Character
	You are given an array of characters (a..z) and a target character.
	Write a script to find out the smallest character in the given array lexicographically greater than the target character.

'''

def smallest_greatest_character(character_list, target_character):
	target_character_ascii = ord(target_character)
	smallest_greatest_character_ascii = 257

	for i in character_list:
		character_ascii = ord(i)

		if character_ascii <= target_character_ascii: continue
		if character_ascii < smallest_greatest_character_ascii: smallest_greatest_character_ascii = character_ascii

	if (smallest_greatest_character_ascii == 257):
		smallest_greatest_character_ascii = target_character_ascii

	return chr(smallest_greatest_character_ascii)

def test_smallest_greatest_character():
	assert smallest_greatest_character(['e', 'm', 'u', 'g'], 'b') == 'e', 'Example 1 Failed'
	assert smallest_greatest_character(['d', 'c', 'e', 'f'], 'a') == 'c', 'Example 2 Failed'
	assert smallest_greatest_character(['j', 'a', 'r'], 'o') == 'r', 'Example 3 Failed'
	assert smallest_greatest_character(['d', 'c', 'a', 'f' ], 'a') == 'c', 'Example 4 Failed'
	assert smallest_greatest_character(['t', 'g', 'a', 'l'], 'v') == 'v', 'Example 5 Failed'

	return

test_smallest_greatest_character()
