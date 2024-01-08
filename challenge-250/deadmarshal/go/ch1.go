package main

import (
	"fmt"
)

func smallestIndex(arr []int) int {
	for i, v := range arr {
		if i%10 == v {
			return i
		}
	}
	return -1
}

func main() {
	fmt.Println(smallestIndex([]int{0, 1, 2}))
	fmt.Println(smallestIndex([]int{4, 3, 2, 1}))
	fmt.Println(smallestIndex([]int{1, 2, 3, 4, 5, 6, 7, 8, 9, 0}))
}
