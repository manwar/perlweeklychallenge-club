package main

import "fmt"

func main() {
	bitStr(2)
	print("\n")
	bitStr(3)
}

func bitStr(n int) {
	limit := 1 << n
	for i := 0; i < limit; i++ {
		value := i
		fmt.Printf("%.*b\n", n, value)
	}
}
