package main

import (
	"fmt"
	"strings"
)

func replaceE(s string) (int, string) {
	count := strings.Count(s, "e")
	replaced := strings.ReplaceAll(s, "e", "E")
	return count, replaced
}

func main() {
	input := "Perl Weekly Challenge"
	count, replaced := replaceE(input)
	fmt.Printf("Original: %s\n", input)
	fmt.Printf("Count: %d\n", count)
	fmt.Printf("Replaced: %s\n", replaced)
}
