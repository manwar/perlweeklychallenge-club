package main

import (
	"fmt"
)

func arrayFromCompute(arr []int, k int) []int {
	i, carry := len(arr)-1, 0
	res := []int{}
	for i >= 0 || k > 0 || carry > 0 {
		if i < 0 {
			carry += k % 10
		} else {
			carry += arr[i] + k%10
			i--
		}
		res = append([]int{carry % 10}, res...)
		carry /= 10
		k /= 10
	}
	return res
}

func main() {
	fmt.Println(arrayFromCompute([]int{1, 2, 3, 4}, 12))
	fmt.Println(arrayFromCompute([]int{2, 7, 4}, 181))
	fmt.Println(arrayFromCompute([]int{9, 9, 9}, 1))
	fmt.Println(arrayFromCompute([]int{1, 0, 0, 0, 0}, 9999))
	fmt.Println(arrayFromCompute([]int{0}, 1000))
}
