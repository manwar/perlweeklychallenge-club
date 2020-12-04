// To compile and run:
// $ go run ch-1.go 100
// 13015

package main

import (
	"fmt"
	"os"
	"strconv"
)

func gcd(a, b int) int {
	for b != 0 {
		b, a = a%b, b
	}

	return a
}

func main() {
	n := 3
	if len(os.Args) == 2 {
		n, _ = strconv.Atoi(os.Args[1])
	}

	s := 0
	for x := 1; x <= n; x++ {
		for y := x + 1; y <= n; y++ {
			s += gcd(x, y)
		}
	}

	fmt.Println(s)
}
