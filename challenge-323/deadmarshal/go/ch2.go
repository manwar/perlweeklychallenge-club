package main

import (
	"fmt"
)

func tax_amount(income int, taxes [][]int) float64 {
	res := 0
	prev := 0
	for _, e := range taxes {
		res += max(0, min(income, e[0])-prev) * e[1]
		prev = e[0]
	}
	return float64(res) / 100.0
}

func main() {
	fmt.Println(tax_amount(10, [][]int{{3, 50}, {7, 10}, {12, 25}}))
	fmt.Println(tax_amount(2, [][]int{{1, 0}, {4, 25}, {5, 50}}))
	fmt.Println(tax_amount(0, [][]int{{2, 50}}))
}
