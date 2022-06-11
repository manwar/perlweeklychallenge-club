package main

import "fmt"

func main() {
	var lf int
	for i := 0; i < 10; i++ {
		lf += factorial(i)
		if i != 0 {
			fmt.Print(", ")
		}
		fmt.Print(lf)
	}
	fmt.Printf("\n")
}
func factorial(n int) int {
	r := 1
	if n == 0 {
		return r
	}
	for i := 1; i <= n; i++ {
		r *= i
	}
	return r
}
