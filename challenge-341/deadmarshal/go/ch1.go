package main

import (
	"fmt"
	"strings"
)

func brokenKeyboard(str string, runes []rune) int {
	chars := string(runes)
	words := strings.Fields(str)
	if chars == "" {
		return len(words)
	}
	c := 0
	for _, w := range words {
		if !strings.ContainsAny(strings.ToLower(w), chars) {
			c += 1
		}
	}
	return c
}

func main() {
	fmt.Println(brokenKeyboard("Hello World", []rune{'d'}))
	fmt.Println(brokenKeyboard("apple banana cherry", []rune{'a', 'e'}))
	fmt.Println(brokenKeyboard("Coding is fun", []rune{}))
	fmt.Println(brokenKeyboard("The Weekly Challenge", []rune{'a', 'b'}))
	fmt.Println(brokenKeyboard("Perl and Python", []rune{'p'}))
}
