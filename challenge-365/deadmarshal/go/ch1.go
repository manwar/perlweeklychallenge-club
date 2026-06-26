package main

import (
	"strconv"
	"strings"
)

func digitsSum(num int) int {
	sum := 0
	for num > 0 {
		sum += num % 10
		num /= 10
	}
	return sum
}

func alphabetIndexDigitSum(s string, k int) int {
	var sb strings.Builder
	for _, c := range s {
		sb.WriteString(strconv.Itoa(int(c - 'a' + 1)))
	}

	num, _ := strconv.Atoi(sb.String())

	for i := 0; i < k; i++ {
		num = digitsSum(num)
	}

	return num
}
