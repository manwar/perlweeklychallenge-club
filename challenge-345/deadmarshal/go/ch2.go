package main

import (
	"fmt"
)

func lastVisitor(arr []int) []int {
	res, seen := []int{}, []int{}
	k := 0
	for _, e := range arr {
		if e != -1 {
			seen = append(seen, e)
			k = len(seen)
		} else if k == 0 {
			res = append(res, -1)
		} else {
			k--
			res = append(res, seen[k])
		}
	}
	return res
}

func main() {
	fmt.Println(lastVisitor([]int{5, -1, -1}))
	fmt.Println(lastVisitor([]int{3, 7, -1, -1, -1}))
	fmt.Println(lastVisitor([]int{2, -1, 4, -1, -1}))
	fmt.Println(lastVisitor([]int{10, 20, -1, 30, -1, -1}))
	fmt.Println(lastVisitor([]int{-1, -1, 5, -1}))
}
