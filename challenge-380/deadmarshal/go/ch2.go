package main

import "strings"

func reverseDegree(s string) int {
	sum := 0
	for i, c := range strings.ToLower(s) {
		if c < 'a' || c > 'z' {
			continue
		}
		value := 26 - int(c-'a')
		sum += value * (i + 1)
	}
	return sum
}
