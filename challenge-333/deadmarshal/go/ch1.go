package main

import (
	"fmt"
)

func straightLine(arr [][]int) bool {
	x1, y1 := arr[0][0], arr[0][1]
	x2, y2 := arr[1][0], arr[1][1]
	for i := 2; i < len(arr); i++ {
		x, y := arr[i][0], arr[i][1]
		if (x-x1)*(y2-y1) != (y-y1)*(x2-x1) {
			return false
		}
	}
	return true
}

func main() {
	fmt.Println(straightLine([][]int{{2, 1}, {2, 3}, {2, 5}}))
	fmt.Println(straightLine([][]int{{1, 4}, {3, 4}, {10, 4}}))
	fmt.Println(straightLine([][]int{{0, 0}, {1, 1}, {2, 3}}))
	fmt.Println(straightLine([][]int{{1, 1}, {1, 1}, {1, 1}}))
	fmt.Println(straightLine([][]int{{1000000, 1000000},
		{2000000, 2000000},
		{3000000, 3000000}}))
}
