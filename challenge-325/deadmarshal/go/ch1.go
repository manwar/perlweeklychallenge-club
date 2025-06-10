package main

import (
	"fmt"
)

func consecutiveOne(arr []int) int {
	count, res := 0, 0
	for _, e := range arr {
		if e == 1 {
			count++
		} else {
			res = max(res, count)
			count = 0
		}
	}
	return max(count, res)
}

func main() {
	fmt.Println(consecutiveOne([]int{0, 1, 1, 0, 1, 1, 1}))
	fmt.Println(consecutiveOne([]int{0, 0, 0, 0}))
	fmt.Println(consecutiveOne([]int{1, 0, 1, 0, 1, 1}))
}
