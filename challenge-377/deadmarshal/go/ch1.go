package main

import (
	"strings"
)

func reverseExistence(s string) bool {
	rev := reverseString(s)
	for i := 0; i < len(s)-1; i++ {
		sub := s[i : i+2]
		if strings.Contains(rev, sub) {
			return true
		}
	}
	return false
}

func reverseString(s string) string {
	runes := []rune(s)
	for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
		runes[i], runes[j] = runes[j], runes[i]
	}
	return string(runes)
}
