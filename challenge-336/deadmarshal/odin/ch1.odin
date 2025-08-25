package main

import "core:fmt"

frequency :: proc(arr: []int) -> map[int]int {
	f := make(map[int]int)
	for n, _ in arr {
		f[n] = f[n] + 1
	}
	return f
}

gcd :: proc(a, b: int) -> int {
	if b == 0 {
		return a
	}
	return gcd(b, a % b)
}

equalGroup :: proc(arr: []int) -> bool {
	h := frequency(arr)
	defer delete(h)

	values := make([dynamic]int, len(h))
	defer delete(values)

	for _, v in h do append_elem(&values, v)

	if len(values) == 0 {
		return false
	}

	res := values[0]

	for &v, _ in values {
		res = gcd(res, v)
	}

	return res > 1
}

main :: proc() {
	fmt.println(equalGroup([]int{1, 1, 2, 2, 2, 2}))
	fmt.println(equalGroup([]int{1, 1, 1, 2, 2, 2, 3, 3}))
	fmt.println(equalGroup([]int{5, 5, 5, 5, 5, 5, 7, 7, 7, 7, 7, 7}))
	fmt.println(equalGroup([]int{1, 2, 3, 4}))
	fmt.println(equalGroup([]int{8, 8, 9, 9, 10, 10, 11, 11}))
}
