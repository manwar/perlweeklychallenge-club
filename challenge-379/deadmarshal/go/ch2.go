package main

import (
	"math"
)

func digits(base, num int) []int {
	if num == 0 {
		return []int{0}
	}
	res := []int{}
	for num > 0 {
		res = append(res, num%base)
		num /= base
	}
	return res
}

func isArmstrong(base, limit int) []int {
	res := []int{}
	for n := 0; n <= limit; n++ {
		ds := digits(base, n)
		sum := 0
		for _, v := range ds {
			sum += int(math.Pow(float64(v), float64(len(ds))))
		}
		if sum == n {
			res = append(res, n)
		}
	}
	return res
}
