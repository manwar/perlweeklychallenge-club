package main

import (
	"strings"
)

func specialBinarySubstrings(b string) []string {
	var m []string
	runes := []rune(b)

	for pos := 0; pos < len(runes); pos++ {
		for length := 2; pos+length <= len(runes); length++ {
			sub := string(runes[pos : pos+length])

			if !strings.Contains(sub, "01") && !strings.Contains(sub, "10") {
				continue
			}

			trans, idx := 0, -1
			for i := 1; i < len(sub); i++ {
				if sub[i] != sub[i-1] {
					idx = i
					trans++
					break
				}
			}

			if trans != 1 {
				continue
			}

			if len(sub[:idx]) == len(sub[idx:]) {
				m = append(m, sub)
			}
		}
	}
	return m
}
