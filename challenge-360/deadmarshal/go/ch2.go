package main

import (
	"fmt"
	"slices"
	"strings"
)

func wordSorter(str string) string {
	words := strings.Fields(str)
	slices.SortFunc(words, func(a, b string) int {
		return strings.Compare(strings.ToLower(a), strings.ToLower(b))
	})
	return strings.Join(words, " ")
}

func main() {
	fmt.Println(wordSorter("The quick brown fox"))
	fmt.Println(wordSorter("Hello    World!   How   are you?"))
	fmt.Println(wordSorter("Hello"))
	fmt.Println(wordSorter("Hello, World! How are you?"))
	fmt.Println(wordSorter("I have 2 apples and 3 bananas!"))
}
