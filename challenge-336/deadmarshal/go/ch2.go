package main

import (
	"fmt"
	"strconv"
)

func finalScore(arr []string) int {
	stk := []int{}
	sum := 0
	for _, s := range arr {
		if i, err := strconv.Atoi(s); err == nil {
			stk = append(stk, i)
		} else if s == "C" {
			stk = stk[:len(stk)-1]
		} else if s == "D" {
			stk = append(stk, stk[len(stk)-1]*2)
		} else {
			stk = append(stk, stk[len(stk)-1]+stk[len(stk)-2])
		}
	}

	for _, v := range stk {
		sum += v
	}
	return sum
}

func main() {
	fmt.Println(finalScore([]string{"5", "2", "C", "D", "+"}))
	fmt.Println(finalScore([]string{"5", "-2", "4", "C", "D", "9",
		"+", "+"}))
	fmt.Println(finalScore([]string{"7", "D", "D", "C", "+", "3"}))
	fmt.Println(finalScore([]string{"-5", "-10", "+", "D", "C", "+"}))
	fmt.Println(finalScore([]string{"3", "6", "+", "D", "C", "8",
		"+", "D", "-2", "C", "+"}))
}
