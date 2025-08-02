package main

import (
	"fmt"
)

func finalPrice(prices []int) []int {
	var stk Stack[int]
	for i, _ := range prices {
		p, _ := stk.Peek()
		for !stk.IsEmpty() && prices[p] >= prices[i] {
			popped, _ := stk.Pop()
			prices[popped] -= prices[i]
		}
		stk.Push(i)
	}
	return prices
}

func main() {
	fmt.Println(finalPrice([]int{8, 4, 6, 2, 3}))
	fmt.Println(finalPrice([]int{1, 2, 3, 4, 5}))
	fmt.Println(finalPrice([]int{7, 1, 1, 5}))
}
