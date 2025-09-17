package main

import (
	"fmt"
	"slices"
)

func peakPoint(arr []int) int {
	res := []int{0}
	for _, e := range arr {
		res = append(res, res[len(res)-1]+e)
	}
	return slices.Max(res)
}

func main() {
	fmt.Println(peakPoint([]int{-5, 1, 5, -9, 2}))
	fmt.Println(peakPoint([]int{10, 10, 10, -25}))
	fmt.Println(peakPoint([]int{3, -4, 2, 5, -6, 1}))
	fmt.Println(peakPoint([]int{-1, -2, -3, -4}))
	fmt.Println(peakPoint([]int{-10, 15, 5}))
}
