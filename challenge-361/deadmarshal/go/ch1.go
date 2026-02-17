package main

import (
	"fmt"
)

func zeckendorfRepresentation(n int) []int {
	fibs := []int{1, 2}
	for fibs[len(fibs)-1]+fibs[len(fibs)-2] <= n {
		fibs = append(fibs, fibs[len(fibs)-1]+fibs[len(fibs)-2])
	}
	i, rem, parts := len(fibs)-1, n, []int{}
	for rem != 0 {
		if fibs[i] <= rem {
			parts = append(parts, fibs[i])
			rem -= fibs[i]
			i -= 2
		} else {
			i--
		}
	}
	return parts
}

func main() {
	fmt.Println(zeckendorfRepresentation(4))
	fmt.Println(zeckendorfRepresentation(12))
	fmt.Println(zeckendorfRepresentation(20))
	fmt.Println(zeckendorfRepresentation(96))
	fmt.Println(zeckendorfRepresentation(100))
}
