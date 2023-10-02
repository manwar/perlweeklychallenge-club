package main

import (
	"fmt"
)

func removeOne(arr []int) bool {
	c1, c2, idx1, idx2 := 0, 0, -1, -1
	for i := 1; i < len(arr); i++ {
		if arr[i] <= arr[i-1] {
			c1++
			idx1 = i - 1
		}
	}
	for i := len(arr) - 2; i > 0; i-- {
		if arr[i] >= arr[i+1] {
			c2++
			idx2 = i + 1
		}
	}
	if c1 == 1 && c2 == 1 && idx2-idx1+2 == 2 {
		return true
	}
	if c1 > 1 || c2 > 1 {
		return false
	}
	return true
}

func main() {
	arr1 := []int{0, 2, 9, 4, 5}
	arr2 := []int{5, 1, 3, 2}
	arr3 := []int{2, 2, 3}
	fmt.Println(removeOne(arr1))
	fmt.Println(removeOne(arr2))
	fmt.Println(removeOne(arr3))
}
