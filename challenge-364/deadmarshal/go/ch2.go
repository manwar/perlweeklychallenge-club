package main

import "strings"

func goalParser(s string) string {
	s = strings.ReplaceAll(s, "()", "o")
	s = strings.ReplaceAll(s, "(al)", "al")
	return s
}
