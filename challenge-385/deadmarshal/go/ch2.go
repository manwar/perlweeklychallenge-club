package main

import (
	"strings"
)

func outermostParentheses(s string) string {
	var res strings.Builder
	depth := 0
	for _, ch := range s {
		switch ch {
		case '(':
			if depth > 0 {
				res.WriteRune(ch)
			}
			depth++
		case ')':
			depth--
			if depth > 0 {
				res.WriteRune(ch)
			}
		}
	}
	return res.String()
}
