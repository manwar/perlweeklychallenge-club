package main

import (
	"fmt"
	"strings"
)

func removeLeadingZeros(s string) string {
	res := strings.TrimLeft(s, "0")
	if res == "" {
		return "0"
	}
	return res
}

func main() {
	fmt.Println(removeLeadingZeros("0001234"))
	fmt.Println(removeLeadingZeros("000"))
}
