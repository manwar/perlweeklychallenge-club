package main

import (
	"fmt"
	"slices"
)

func distributeElements(arr []int) []int {
	ret1 := []int{arr[0]}
	arr = slices.Delete(arr, 0, 1)
	ret2 := []int{arr[0]}
	arr = slices.Delete(arr, 0, 1)
	for len(arr) != 0 {
		e := arr[0]
		arr = slices.Delete(arr,0,1)
		if ret1[len(ret1)-1] > ret2[len(ret2)-1] {
			ret1 = append(ret1,e)
			continue
		}
		ret2 = append(ret2,e)
	}
	return slices.Concat(nil,ret1,ret2)
}

func main() {
	arr1 := []int{2, 1, 3, 4, 5}
	arr2 := []int{3, 2, 4}
	arr3 := []int{5, 4, 3, 8}
	fmt.Println(distributeElements(arr1))
	fmt.Println(distributeElements(arr2))
	fmt.Println(distributeElements(arr3))
}
