package main

import (
	"strings"
)

func uncommonWords(s1, s2 string) []string {
	wc := make(map[string]int)
	for _, w := range strings.Fields(s1 + " " + s2) {
		wc[w]++
	}
	res := []string{}
	for w, c := range wc {
		if c == 1 {
			res = append(res, w)
		}
	}
	return res
}
