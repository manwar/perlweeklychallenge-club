package main

import (
	"fmt"
	"strings"
)

func incrementDecrement(arr []string) int {
	x := 0
	for _, v := range arr {
		if strings.Contains(v, "++") {
			x++
		} else {
			x--
		}
	}
	return x
}

func main() {
	arr1 := []string{"--x", "x++", "x++"}
	arr2 := []string{"x++", "++x", "x++"}
	arr3 := []string{"x++", "++x", "--x", "x--"}
	fmt.Println(incrementDecrement(arr1))
	fmt.Println(incrementDecrement(arr2))
	fmt.Println(incrementDecrement(arr3))
}
