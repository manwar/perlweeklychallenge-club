package main

import (
	"fmt"
)

func duplicateZeros(arr []int) {
	n := len(arr)
	i, k := -1, 0
	for k < n {
		i, k = i+1, k+1
		if arr[i] == 0 {
			k++
		}
	}
	j := n - 1
	if k == n+1 {
		arr[j] = 0
		i, j = i-1, j-1
	}
	for j >= 0 {
		arr[j] = arr[i]
		if arr[i] == 0 {
			j--
			arr[j] = arr[i]
		}
		i, j = i-1, j-1
	}
}

func main() {
	a1 := []int{1, 0, 2, 3, 0, 4, 5, 0}
	a2 := []int{1, 2, 3}
	a3 := []int{1, 2, 3, 0}
	a4 := []int{0, 0, 1, 2}
	a5 := []int{1, 2, 0, 3, 4}
	duplicateZeros(a1)
	duplicateZeros(a2)
	duplicateZeros(a3)
	duplicateZeros(a4)
	duplicateZeros(a5)
	fmt.Println(a1)
	fmt.Println(a2)
	fmt.Println(a3)
	fmt.Println(a4)
	fmt.Println(a5)
}
