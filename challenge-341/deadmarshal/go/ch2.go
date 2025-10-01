package main

import (
	"fmt"
	"strings"
)

func reverse(s string) string {
	r := []rune(s)
	for i, j := 0, len(r)-1; i < len(r)/2; i, j = i+1, j-1 {
		r[i], r[j] = r[j], r[i]
	}
	return string(r)
}

func reversePrefix(str string, c rune) string {
	idx := strings.IndexRune(str, c)
	return reverse(str[0:idx+1]) + str[idx+1:]
}

func main() {
	fmt.Println(reversePrefix("programming", 'g'))
	fmt.Println(reversePrefix("hello", 'h'))
	fmt.Println(reversePrefix("abcdefghij", 'h'))
	fmt.Println(reversePrefix("reverse", 's'))
	fmt.Println(reversePrefix("perl", 'r'))
}
