package main

import (
	"fmt"
	"strings"
)

func countVowels(s string) (c int) {
	for _, ch := range strings.ToLower(s) {
		switch ch {
		case 'a', 'e', 'i', 'o', 'u':
			c++
		}
	}
	return
}

func stringAlike(s string) bool {
	mid := len(s) / 2
	a, b := countVowels(s[:mid]), countVowels(s[mid:])
	return a == b && a != 0
}

func main() {
	fmt.Println(stringAlike("textbook"))
	fmt.Println(stringAlike("book"))
	fmt.Println(stringAlike("AbCdEfGh"))
	fmt.Println(stringAlike("rhythmmyth"))
	fmt.Println(stringAlike("UmpireeAudio"))
}
