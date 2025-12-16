package main

import (
	"fmt"
)

func binaryPrefix(arr []int) []bool {
	x := 0
	res := []bool{}
	for _, v := range arr {
		x = (x<<1 | v) % 5
		res = append(res, x == 0)
	}
	return res
}

func main() {
	fmt.Println(binaryPrefix([]int{0, 1, 1, 0, 0, 1, 0, 1, 1, 1}))
	fmt.Println(binaryPrefix([]int{1, 0, 1, 0, 1, 0}))
	fmt.Println(binaryPrefix([]int{0, 0, 1, 0, 1}))
	fmt.Println(binaryPrefix([]int{1, 1, 1, 1, 1}))
	fmt.Println(binaryPrefix([]int{1, 0, 1, 1, 0, 1, 0, 0, 1, 1}))
}
