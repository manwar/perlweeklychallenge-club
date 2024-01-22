#!/usr/bin/env -S v run

module main

fn unique_sum_zero(n int) []int {
	mut ints := []int{}
	for i in 1 .. (n / 2) + 1 {
		ints << [i, -i]
	}
	if n % 2 == 1 {
		ints << 0
	}
	ints.sort()
	return ints
}
