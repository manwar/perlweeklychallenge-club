package main

import (
	"fmt"
)

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func maxDistance(a1, a2 []int) int {
	var max int
	for _, v := range a1 {
		for _, v2 := range a2 {
			abs := abs(v - v2)
			if abs > max {
				max = abs
			}
		}
	}
	return max
}

func main() {
	fmt.Println(maxDistance([]int{4, 5, 7}, []int{9, 1, 3, 4}))
	fmt.Println(maxDistance([]int{2, 3, 5, 4}, []int{3, 2, 5, 5, 8, 7}))
	fmt.Println(maxDistance([]int{2, 1, 11, 3}, []int{2, 5, 10, 2}))
	fmt.Println(maxDistance([]int{1, 2, 3}, []int{3, 2, 1}))
	fmt.Println(maxDistance([]int{1, 0, 2, 3}, []int{5, 0}))
}
