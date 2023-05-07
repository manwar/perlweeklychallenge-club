package main

import (
	"fmt"
	"os"
	"sort"
	"strings"
)

func IsNotAlphaOrder(input string) (res bool) {

	chars := strings.Split(input, "")

	sort.Strings(chars)
	sorted := strings.Join(chars, "")

	out_of_order := input != sorted
	return out_of_order
}

func Count(list []string) (res int) {

	count := 0
	for _, word := range list {
		if IsNotAlphaOrder(word) {
			count++
		}
	}

	return count
}

func main() {
	words := os.Args[1:]
	fmt.Println("Input: ", strings.Join(words, ", "))
	fmt.Println(" Output: ", Count(words))

}
