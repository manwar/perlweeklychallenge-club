package main

import (
	"fmt"
	"slices"
)

func maxDiff(arr []int) int {
	slices.Sort(arr)
	n := len(arr)
	return arr[n-1]*arr[n-2] - arr[0]*arr[1]
}

func main() {
	fmt.Println(maxDiff([]int{5, 9, 3, 4, 6}))
	fmt.Println(maxDiff([]int{1, -2, 3, -4}))
	fmt.Println(maxDiff([]int{-3, -1, -2, -4}))
	fmt.Println(maxDiff([]int{10, 2, 0, 5, 1}))
	fmt.Println(maxDiff([]int{7, 8, 9, 10, 10}))
}
