package main

import (
	"fmt"
)

func peakPositions(arr []int) []int {
	res := []int{}
	for i := 1; i < len(arr)-1; i++ {
		if arr[i-1] < arr[i] && arr[i+1] < arr[i] {
			res = append(res, i)
		}
	}
	return res
}

func main() {
	fmt.Println(peakPositions([]int{1, 3, 2}))
	fmt.Println(peakPositions([]int{2, 4, 6, 5, 3}))
	fmt.Println(peakPositions([]int{1, 2, 3, 2, 4, 1}))
	fmt.Println(peakPositions([]int{5, 3, 1}))
	fmt.Println(peakPositions([]int{1, 5, 1, 5, 1, 5, 1}))
}
