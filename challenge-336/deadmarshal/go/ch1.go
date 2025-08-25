package main

import (
	"fmt"
)

func frequency(arr []int) map[int]int {
	f := make(map[int]int)
	for _, n := range arr {
		f[n] = f[n] + 1
	}
	return f
}

func gcd(a, b int) int {
	for b > 0 {
		c := a % b
		a = b
		b = c
	}
	return a
}

func equalGroup(arr []int) bool {
	h := frequency(arr)

	values := make([]int, 0, len(h))
	for _, v := range h {
		values = append(values, v)
	}

	if len(values) == 0 {
		return false
	}

	res := values[0]
	for i := 1; i < len(values); i++ {
		res = gcd(res, values[i])
	}

	return res > 1
}

func main() {
	fmt.Println(equalGroup([]int{1, 1, 2, 2, 2, 2}))
	fmt.Println(equalGroup([]int{1, 1, 1, 2, 2, 2, 3, 3}))
	fmt.Println(equalGroup([]int{5, 5, 5, 5, 5, 5, 7, 7, 7, 7, 7, 7}))
	fmt.Println(equalGroup([]int{1, 2, 3, 4}))
	fmt.Println(equalGroup([]int{8, 8, 9, 9, 10, 10, 11, 11}))
}
