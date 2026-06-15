package main

import (
	"fmt"
)

func sumOfWords(s1, s2, s3 string) bool {
	f := func(s string) int {
		res := 0
		for _, c := range s {
			res = res*10 + int(c-'a')
		}
		return res
	}
	return f(s1)+f(s2) == f(s3)
}

func main() {
	fmt.Println(sumOfWords("acb", "cba", "cdb"))
	fmt.Println(sumOfWords("aab", "aac", "ad"))
	fmt.Println(sumOfWords("bc", "je", "jg"))
	fmt.Println(sumOfWords("a", "aaaa", "aa"))
	fmt.Println(sumOfWords("c", "d", "h"))
	fmt.Println(sumOfWords("gfi", "hbf", "bdhd"))
}
