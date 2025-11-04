package main

import (
	"fmt"
	"strconv"
)

func magicExpression(num string, target int) []string {
	out := []string{}
	var backtrack func(string, string, int, int)
	backtrack = func(num, prefix string, val, last int) {
		if len(num) == 0 {
			if val == target {
				out = append(out, prefix)
			}
			return
		}
		for i := 1; i <= len(num); i++ {
			str := num[:i]
			digit, _ := strconv.Atoi(str)
			if num[0] == '0' && i != 1 {
				continue
			}

			if prefix == "" {
				backtrack(num[i:], str, digit, digit)
			} else {
				backtrack(num[i:], prefix+"+"+str, val+digit, digit)
				backtrack(num[i:], prefix+"-"+str, val-digit, -digit)
				backtrack(num[i:], prefix+"*"+str, val-last+last*digit,
					last*digit)
			}
		}
	}
	backtrack(num, "", 0, 0)
	return out
}

func main() {
	fmt.Println(magicExpression("123", 6))
	fmt.Println(magicExpression("105", 5))
	fmt.Println(magicExpression("232", 8))
	fmt.Println(magicExpression("1324", 10))
	fmt.Println(magicExpression("1001", 2))
}
