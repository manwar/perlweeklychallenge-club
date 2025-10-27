package main

import (
	"fmt"
)

func arrayFormation(source [][]int, target []int) bool {
	for i := 0; i < len(target); {
		k := 0
		for k < len(source) && source[k][0] != target[i] {
			k++
		}
		if k == len(source) {
			return false
		}
		j := 0
		for j < len(source[k]) && target[i] == source[k][j] {
			i++
			j++
		}
	}
	return true
}

func main() {
	fmt.Println(arrayFormation([][]int{{2, 3}, {1}, {4}}, []int{1, 2, 3, 4}))
	fmt.Println(arrayFormation([][]int{{1, 3}, {2, 4}}, []int{1, 2, 3, 4}))
	fmt.Println(arrayFormation([][]int{{9, 1}, {5, 8}, {2}}, []int{5, 8, 2, 9, 1}))
	fmt.Println(arrayFormation([][]int{{1}, {3}}, []int{1, 2, 3}))
	fmt.Println(arrayFormation([][]int{{7, 4, 6}}, []int{7, 4, 6}))
}
