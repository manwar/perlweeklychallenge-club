package main

import (
	"fmt"
)

func reversePairs(arr []int) int {
	count := 0
	for i := 0; i < len(arr)-1; i++ {
		for j := i + 1; j < len(arr); j++ {
			if arr[i] > 2*arr[j] {
				count += 1
			}
		}
	}
	return count
}

func main() {
	arr1 := []int{1, 3, 2, 3, 1}
	arr2 := []int{2, 4, 3, 5, 1}
	fmt.Println(reversePairs(arr1))
	fmt.Println(reversePairs(arr2))
}
