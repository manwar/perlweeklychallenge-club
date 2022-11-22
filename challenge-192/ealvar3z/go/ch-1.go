package main

import "math/bits"

func max(x, y int) int {
	if x > y {
		return x
	}
	return y
}

func BinaryFlip(n int) int {
	mask := max(1, (1<<(bits.Len(uint(n))) - 1))
	return n ^ mask
}
