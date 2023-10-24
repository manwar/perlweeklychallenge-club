package main

import (
	"fmt"
)

func buildArray(arr []int) []int {
	ret := make([]int, len(arr))
	for i, _ := range arr {
		ret[i] = arr[arr[i]]
	}
	return ret
}

func main() {
	arr1 := []int{0, 2, 1, 5, 3, 4}
	arr2 := []int{5, 0, 1, 2, 3, 4}
	fmt.Println(buildArray(arr1))
	fmt.Println(buildArray(arr2))
}
