package main

import "fmt"

func decompressedList(arr []int) []int {
	res := []int{}
	for i := 0; i < len(arr); i += 2 {
		for j := 1; j <= arr[i]; j++ {
			res = append(res, arr[i+1])
		}
	}
	return res
}

func main() {
	fmt.Println(decompressedList([]int{1, 3, 2, 4}))
	fmt.Println(decompressedList([]int{1, 1, 2, 2}))
	fmt.Println(decompressedList([]int{3, 1, 3, 2}))
}
