package main

import (
	"fmt"
)

func floorSum(arr []int) int {
	sum := 0
	for _, v1 := range arr {
		for _, v2 := range arr {
			sum += v1 / v2
		}
	}
	return sum
}

func main() {
	arr1 := []int{2, 5, 9}
	arr2 := []int{7, 7, 7, 7, 7, 7, 7}
	fmt.Println(floorSum(arr1))
	fmt.Println(floorSum(arr2))
}
