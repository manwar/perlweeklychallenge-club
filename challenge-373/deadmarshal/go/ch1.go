package main

import (
	"fmt"
	"strings"
)

func equalList(left, right []string) bool {
	return strings.Join(left, "") == strings.Join(right, "")
}

func main() {
	fmt.Println(equalList([]string{"a", "bc"}, []string{"ab", "c"}))
	fmt.Println(equalList([]string{"a", "b", "c"}, []string{"a", "bc"}))
	fmt.Println(equalList([]string{"a", "bc"}, []string{"a", "c", "b"}))
	fmt.Println(equalList([]string{"ab", "c", ""}, []string{"", "a", "bc"}))
	fmt.Println(equalList([]string{"p", "e", "r", "l"}, []string{"perl"}))
}
