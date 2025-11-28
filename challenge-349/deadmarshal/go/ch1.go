package main

import (
	"fmt"
)

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func powerString(s string) int {
	res, temp := 1, 1
	for i := 1; i < len(s); i++ {
		if s[i] == s[i-1] {
			temp++
			res = max(res, temp)
		} else {
			temp = 1
		}
	}
	return res
}

func main() {
	fmt.Println(powerString("textbook"))
	fmt.Println(powerString("aaaaa"))
	fmt.Println(powerString("hoorayyy"))
	fmt.Println(powerString("x"))
	fmt.Println(powerString("aabcccddeeffffghijjk"))
}
