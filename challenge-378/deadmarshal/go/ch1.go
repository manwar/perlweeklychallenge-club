package main

import (
	"fmt"
)

func secondLargestDigit(s string) int {
	a, b := -1, -1
	for _, c := range s {
		if c >= '0' && c <= '9' {
			v := int(c - '0')
			if v > a {
				b, a = a, v
			} else if v > b && v < a {
				b = v
			}
		}
	}
	return b
}

func main() {
	fmt.Println(secondLargestDigit("aaaaa77777"))
	fmt.Println(secondLargestDigit("abcde"))
	fmt.Println(secondLargestDigit("9zero8eight7seven9"))
	fmt.Println(secondLargestDigit("xyz9876543210"))
	fmt.Println(secondLargestDigit("4abc4def2ghi8jkl2"))
}
