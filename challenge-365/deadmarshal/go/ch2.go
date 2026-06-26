package main

import (
	"regexp"
	"strings"
)

func validTokenCounter(s string) int {
	p := regexp.MustCompile("^(?:[a-z]+-)?[a-z]+[?!.,]?$")
	c := 0
	for v := range strings.FieldsSeq(s) {
		if p.MatchString(v) {
			c++
		}
	}
	return c
}
