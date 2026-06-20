package main

import (
	"fmt"
)

func listDivision(arr []int, n int) [][]int {
	if n > len(arr) {
		return nil
	}

	sz, rest, res := len(arr)/n, len(arr)%n, make([][]int, 0, n)

	for i := 1; i <= n; i++ {
		take := sz
		if i <= rest {
			take++
		}
		chunk := make([]int, take)
		copy(chunk, arr[:take])
		res = append(res, chunk)

		arr = arr[take:]
	}
	return res
}

func main() {
	fmt.Println(listDivision([]int{1, 2, 3, 4, 5}, 2))
	fmt.Println(listDivision([]int{1, 2, 3, 4, 5, 6}, 3))
	fmt.Println(listDivision([]int{1, 2, 3}, 2))
	fmt.Println(listDivision([]int{1, 2, 3, 4, 5, 6, 7, 8, 9, 10}, 5))
	fmt.Println(listDivision([]int{1, 2, 3}, 4))
	fmt.Println(listDivision([]int{72, 57, 89, 55, 36, 84, 10, 95, 99, 35}, 7))
}
