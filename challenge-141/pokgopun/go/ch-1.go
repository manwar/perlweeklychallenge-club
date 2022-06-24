/*
TASK #1 › Number Divisors
Submitted by: Mohammad S Anwar
Write a script to find lowest 10 positive integers having exactly 8 divisors.

Example
24 is the first such number having exactly 8 divisors.
1, 2, 3, 4, 6, 8, 12 and 24.
*/
package main

import (
	"fmt"
	"math"
)

func main() {
	var (
		count, lim int
		s          []int
	)
	n := 1
	for len(s) < 10 {
		n++
		lim = int(math.Floor(math.Sqrt(float64(n))))
		if n == lim*lim {
			continue
		}
		for d := 1; d <= lim; d++ {
			if n%d == 0 {
				count += 2
			}
		}
		if count == 8 {
			s = append(s, n)
		}
		count = 0
	}
	fmt.Println(s)
}
