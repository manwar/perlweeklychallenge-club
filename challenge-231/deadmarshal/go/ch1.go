package main

import (
	"fmt"
)

func minMax(arr []int) []int {
	min := arr[0]
	max := arr[0]
	ret := []int{}
	for _, value := range arr {
		if max < value {
			max = value
		}
		if min > value {
			min = value
		}
	}
	for _, value := range arr {
		if value != min && value != max {
			ret = append(ret, value)
		}
	}
	return ret
}

func main() {
	arr1 := []int{3, 2, 1, 4}
	arr2 := []int{3, 1}
	arr3 := []int{2, 1, 3}
	fmt.Println(minMax(arr1))
	fmt.Println(minMax(arr2))
	fmt.Println(minMax(arr3))
}
