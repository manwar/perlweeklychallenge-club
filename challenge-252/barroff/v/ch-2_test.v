#!/usr/bin/env -S v -stats test

module main

fn test_odd_number() {
	assert unique_sum_zero(5) == [-2, -1, 0, 1, 2]
	assert unique_sum_zero(3) == [-1, 0, 1]
}

fn test_even_number() {
	assert unique_sum_zero(4) == [-2, -1, 1, 2]
	assert unique_sum_zero(2) == [-1, 1]
}

fn test_zero() {
	assert unique_sum_zero(0) == []
}

fn test_one() {
	assert unique_sum_zero(1) == [0]
}
