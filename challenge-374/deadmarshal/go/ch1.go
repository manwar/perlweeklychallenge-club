package main

import "strings"

func countVowel(str string) []string {
	var res []string
	n := len(str)
	for s := 0; s < n; s++ {
		for l := 5; l <= n-s; l++ {
			sub := str[s : s+l]
			if isAllVowels(sub) && hasAllVowels(sub) {
				res = append(res, sub)
			}
		}
	}
	return res
}

func isAllVowels(s string) bool {
	for _, c := range s {
		switch c {
		case 'a', 'e', 'i', 'o', 'u':
			continue
		default:
			return false
		}
	}
	return true
}

func hasAllVowels(s string) bool {
	for _, v := range []rune{'a', 'e', 'i', 'o', 'u'} {
		if !strings.ContainsRune(s, v) {
			return false
		}
	}
	return true
}
