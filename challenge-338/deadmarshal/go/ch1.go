package main

import (
	"fmt"
)

func highestRow(arr [][]int) int {
	var max int
	for _, a := range arr {
		sum := 0
		for _, v := range a {
			sum += v
		}
		if sum > max {
			max = sum
		}
	}
	return max
}

func main() {
	fmt.Println(highestRow([][]int{{4, 4, 4, 4}, {10, 0, 0, 0}, {2, 2, 2, 9}}))
	fmt.Println(highestRow([][]int{{1, 5}, {7, 3}, {3, 5}}))
	fmt.Println(highestRow([][]int{{1, 2, 3}, {3, 2, 1}}))
	fmt.Println(highestRow([][]int{{2, 7, 8}, {7, 1, 3}, {1, 9, 5}}))
	fmt.Println(highestRow([][]int{{5, 5, 5}, {0, 100, 0}, {25, 25, 25}}))
}
