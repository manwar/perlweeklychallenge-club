package main

import (
	"fmt"
)

func fizzBuzz(n int) []string {
	var result []string
	for i := 1; i <= n; i++ {
		line := ""
		if i%3 == 0 {
			line += "fizz"
		}
		if i%5 == 0 {
			line += "buzz"
		}
		if line == "" {
			result = append(result, fmt.Sprintf("%d", i))
		} else {
			result = append(result, line)
		}
	}
	return result
}

func main() {
	result := fizzBuzz(20)
	for _, val := range result {
		fmt.Println(val)
	}
}
