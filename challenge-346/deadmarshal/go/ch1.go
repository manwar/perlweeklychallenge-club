package main

import (
	"fmt"
)

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func longestParenthesis(s string) int {
	stk := []int{}
	start, res := 0, 0
	for i, c := range s {
		if c == '(' {
			stk = append(stk, i)
		} else {
			if len(stk) == 0 {
				start = i + 1
			} else {
				stk = stk[:len(stk)-1]
				temp := i - start + 1
				if len(stk) == 0 {
					res = max(res, temp)
				} else {
					res = max(res, i-stk[len(stk)-1])
				}
			}
		}
	}
	return res
}

func main() {
	fmt.Println(longestParenthesis("(()())"))
	fmt.Println(longestParenthesis(")()())"))
	fmt.Println(longestParenthesis("((()))()(((()"))
	fmt.Println(longestParenthesis("))))((()("))
	fmt.Println(longestParenthesis("()(()"))
}
