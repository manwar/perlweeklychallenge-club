package main

import (
	"fmt"
)

func bitwiseOr(arr []int) bool {
	count := 0
	for _, v := range arr {
		if v%2 == 0 {
			count++
		}
		if count > 1 {
			return true
		}
	}
	return false
}

func main() {
	fmt.Println(bitwiseOr([]int{1, 2, 3, 4, 5}))
	fmt.Println(bitwiseOr([]int{2, 3, 8, 16}))
	fmt.Println(bitwiseOr([]int{1, 2, 5, 7, 9}))
}
