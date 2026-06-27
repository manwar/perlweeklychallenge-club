package main

import (
	"strings"
)

func countPrefixes(arr []string, s string) (c uint) {
	for _, v := range arr {
		if strings.HasPrefix(s, v) {
			c++
		}
	}
	return
}
