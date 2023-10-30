package main

import (
	"fmt"
)

func runningSum(arr []int) {
	sum := 0
	for _, v := range arr {
		sum += v
		fmt.Printf("%v ", sum)
	}
	fmt.Println()
}

func main() {
	arr1 := []int{1, 2, 3, 4, 5}
	arr2 := []int{1, 1, 1, 1, 1}
	arr3 := []int{0, -1, 1, 2}
	runningSum(arr1)
	runningSum(arr2)
	runningSum(arr3)
}
