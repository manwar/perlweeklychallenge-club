package main

import (
	"fmt"
)

func values(m map[int]int) []int {
	ret := []int{}
	for _, v := range m {
		ret = append(ret, v)
	}
	return ret
}

func disjointSets(arr1, arr2 []int) bool {
	m := make(map[int]int)
	for _, v := range arr1 {
		m[v]++
	}
	for _, v := range arr2 {
		m[v]++
	}
	vals := values(m)
	for _, v := range vals {
		if v > 1 {
			return false
		}
	}
	return true
}

func main() {
	arr1 := []int{1, 2, 5, 3, 4}
	arr2 := []int{4, 6, 7, 8, 9}
	arr3 := []int{1, 3, 5, 7, 9}
	arr4 := []int{0, 2, 4, 6, 8}
	fmt.Println(disjointSets(arr1, arr2))
	fmt.Println(disjointSets(arr3, arr4))
}
