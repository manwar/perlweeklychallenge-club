package main

import (
	"fmt"
	"strings"
)

func maxWords(arr []string) int {
	max := 0
	for _, s := range arr {
		c := len(strings.Fields(s))
		if c > max {
			max = c
		}
	}
	return max
}

func main() {
	fmt.Println(maxWords([]string{"Hello world", "This is a test", "Perl is great"}))
	fmt.Println(maxWords([]string{"Single"}))
	fmt.Println(maxWords([]string{"Short", "This sentence has six words in total", "A B C", "Just four words here"}))
	fmt.Println(maxWords([]string{"One", "Two parts", "Three part phrase", ""}))
	fmt.Println(maxWords([]string{"The quick brown fox jumps over the lazy dog",
		"A",
		"She sells seashells by the seashore",
		"To be or not to be that is the question"}))
}
