package ch1

import "core:testing"

divisible_average :: proc(arr: []int) -> int {
	sum, count: int
	for e in arr {
		if e % 2 == 0 && e % 3 == 0 {
			sum += e
			count += 1
		}
	}
	return count == 0 ? 0 : sum / count
}

@(test)
divisible_average_test :: proc(t: ^testing.T) {
	testing.expect_value(t, divisible_average([]int{18, 5, 7, 11}), 18)
	testing.expect_value(t, divisible_average([]int{6, 12, 18, 24, 30, 40}), 18)
	testing.expect_value(t, divisible_average([]int{3, 9, 15, 21, 27}), 0)
	testing.expect_value(t, divisible_average([]int{6, 12, 14, 20}), 9)
	testing.expect_value(t, divisible_average([]int{6, 6, 6, 12, 12}), 8)
}
