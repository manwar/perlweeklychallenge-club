package main

import (
	"fmt"
	"strconv"
)

func digitalRoot(n int) (int, int) {
	pers := 0
	curr := n
	for curr > 9 {
		strNum := strconv.Itoa(curr)
		sum := 0
		for _, c := range strNum {
			digit, _ := strconv.Atoi(string(c))
			sum += digit
		}
		curr = sum
		pers++
	}
	return pers, curr
}

func main() {
	nums := []int{38, 7, 999, 1999999999, 101010}
	for _, n := range nums {
		pers, root := digitalRoot(n)
		fmt.Printf("Persistence  = %d\nDigital Root = %d\n", pers, root)
	}
}
