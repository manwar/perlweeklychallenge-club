package main

import (
	"fmt"
)

func duplicateZeros(arr []int) []int {
	ret := []int{}
	for _, v := range arr {
		if len(arr) == len(ret) {
			break
		}
		if v == 0 {
			ret = append(ret, []int{0, 0}...)
		} else {
			ret = append(ret, v)
		}
	}
	return ret
}

func main() {
	arr1 := []int{1, 0, 2, 3, 0, 4, 5, 0}
	arr2 := []int{1, 2, 3}
	arr3 := []int{0, 3, 0, 4, 5}
	fmt.Println(duplicateZeros(arr1))
	fmt.Println(duplicateZeros(arr2))
	fmt.Println(duplicateZeros(arr3))
}
