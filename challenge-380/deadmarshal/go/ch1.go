package main

import (
	"strings"
)

func sumOfFrequencies(s string) int {
	m := [26]int{}
	for _, c := range s {
		m[c-'a']++
	}
	a, b := 0, 0
	for i := range m {
		c := byte(i + 'a')
		if strings.ContainsRune("aeiou", rune(c)) {
			a = max(a, m[i])
		} else {
			b = max(b, m[i])
		}
	}
	return a + b
}

