package main

// You are given two positive integers $x and $y.
//
// Write a script to find out the number of operations needed to make both
// ZERO. Each operation is made up either of the followings:
//
// $x = $x - $y if $x >= $y
//
// or
//
// $y = $y - $x if $y >= $x (using the original value of $x)
//
// Example:
// Input: $x = 5, $y = 4
// Output: 5

func Solution(x, y int) int {
	var count int
	for x > 0 && y > 0 {
		if x >= y {
			x = x - y
		} else {
			y = y - x
		}
		count++
	}
	return count
}
