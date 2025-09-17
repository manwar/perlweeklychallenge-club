package main

import "core:fmt"
import "core:slice"

peak_point :: proc(arr: []int) -> int {
	res := [dynamic]int{}
	defer delete(res)
	reserve(&res, len(arr))
	append_elem(&res, 0)
	for e, _ in arr do append_elem(&res, res[len(res) - 1] + e)
	return slice.max(res[:])
}

main :: proc() {
	fmt.println(peak_point([]int{-5, 1, 5, -9, 2}))
	fmt.println(peak_point([]int{10, 10, 10, -25}))
	fmt.println(peak_point([]int{3, -4, 2, 5, -6, 1}))
	fmt.println(peak_point([]int{-1, -2, -3, -4}))
	fmt.println(peak_point([]int{-10, 15, 5}))
}
