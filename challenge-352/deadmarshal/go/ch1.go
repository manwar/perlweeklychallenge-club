package main

import (
	"fmt"
	"slices"
	"strings"
)

func matchString(strs []string) []string {
	res := []string{}
	for i, a := range strs {
		for j, b := range strs {
			if i != j && strings.Contains(b, a) &&
				!slices.Contains(res, a) {
				res = append(res, a)
				break
			}
		}
	}
	return res
}

func main() {
	fmt.Println(matchString([]string{"cat", "cats", "dog", "dogcat",
		"dogcat", "rat", "ratcatdogcat"}))
	fmt.Println(matchString([]string{"hello", "hell", "world",
		"wor", "ellow", "elloworld"}))
	fmt.Println(matchString([]string{"a", "aa", "aaa", "aaaa"}))
	fmt.Println(matchString([]string{"flower", "flow", "flight",
		"fl", "fli", "ig", "ght"}))
	fmt.Println(matchString([]string{"car", "carpet",
		"carpenter", "pet",
		"enter", "pen", "pent"}))
}
