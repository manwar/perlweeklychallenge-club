package main

import (
	"fmt"
	"math"
	"strings"
)

const baseChars = "0123456789ABCDEFGHIJKLMNOPY"

func base35ToInt(s string) int {
	res := 0
	length := len(s)
	for i, char := range s {
		val := strings.IndexRune(baseChars, char)
		if val == -1 {
			continue
		}
		res += val * int(math.Pow(35, float64(length-i-1)))
	}
	return res
}

func intToBase35(n int) string {
	if n == 0 {
		return "0"
	}
	res := ""
	for n > 0 {
		mod := n % 35
		res = string(baseChars[mod]) + res
		n = n / 35
	}
	return res
}

func main() {
	fmt.Println(base35ToInt("A"))
	fmt.Println(base35ToInt("1A"))
	fmt.Println(intToBase35(45))
	fmt.Println(intToBase35(12345))
}
