package main

import (
	"strings"
)

func rearrangeSpaces(s string) string {
	count := strings.Count(s, " ")
	words := strings.Fields(s)
	len := len(words) - 1
	if len == 0 {
		return words[0] + strings.Repeat(" ", count)
	}
	return strings.Join(words, strings.Repeat(" ", count/len)) +
		strings.Repeat(" ", count%len)
}
