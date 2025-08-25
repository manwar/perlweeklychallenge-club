package main

import "core:fmt"
import "core:strconv"

finalScore :: proc(arr: []string) -> (sum: int) {
	stk := [dynamic]int{}

	for s, _ in arr {
		if i, ok := strconv.parse_int(s, 10); ok == true {
			append_elem(&stk, i)
		} else if s == "C" {
			pop(&stk)
		} else if s == "D" {
			append_elem(&stk, stk[len(stk) - 1] * 2)
		} else {
			append_elem(&stk, stk[len(stk) - 1] + stk[len(stk) - 2])
		}
	}

	for v, _ in stk {
		sum += v
	}
	return
}

main :: proc() {
	fmt.println(finalScore([]string{"5", "2", "C", "D", "+"}))
	fmt.println(finalScore([]string{"5", "-2", "4", "C", "D", "9", "+", "+"}))
	fmt.println(finalScore([]string{"7", "D", "D", "C", "+", "3"}))
	fmt.println(finalScore([]string{"-5", "-10", "+", "D", "C", "+"}))
	fmt.println(finalScore([]string{"3", "6", "+", "D", "C", "8", "+", "D", "-2", "C", "+"}))
}
