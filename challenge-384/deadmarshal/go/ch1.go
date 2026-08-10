package main

import "strings"

func reverseString(s string) string {
	runes := []rune(s)
	for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
		runes[i], runes[j] = runes[j], runes[i]
	}
	return string(runes)
}

func baseN(num, base uint) string {
	if num == 0 {
		return "0"
	}

	digits := "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+/"
	var res strings.Builder
	n := num
	for n > 0 {
		rem := int(n % base)
		res.WriteByte(digits[rem])
		n = n / base
	}
	return reverseString(res.String())
}
