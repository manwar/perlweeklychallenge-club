package main

import "core:fmt"
import "core:slice"

max_diff :: proc(arr: []int) -> int {
	slice.sort(arr)
	n := len(arr)
	return arr[n - 1] * arr[n - 2] - arr[0] * arr[1]
}

main :: proc() {
	fmt.println(max_diff([]int{5, 9, 3, 4, 6}))
	fmt.println(max_diff([]int{1, -2, 3, -4}))
	fmt.println(max_diff([]int{-3, -1, -2, -4}))
	fmt.println(max_diff([]int{10, 2, 0, 5, 1}))
	fmt.println(max_diff([]int{7, 8, 9, 10, 10}))
}
