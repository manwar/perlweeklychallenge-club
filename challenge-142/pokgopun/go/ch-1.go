/*
TASK #1 › Divisor Last Digit
Submitted by: Mohammad S Anwar
You are given positive integers, $m and $n.

Write a script to find total count of divisors of $m having last digit $n.

*/
package main

import (
	"fmt"
	"log"
	"os"
	"strings"

	"github.com/pokgopun/go/dldcount"
)

func main() {
	s := make([][2]uint, 1)
	if len(os.Args) > 2 {
		_, err := fmt.Sscanf(strings.Join(os.Args[1:], " "), "%d %d", &s[0][0], &s[0][1])
		if err != nil {
			log.Fatal(err)
		}
	} else {
		s[0] = [2]uint{24, 2}
		s = append(s, [2]uint{30, 5})
	}
	for _, v := range s {
		fmt.Printf("Input: m = %d, n = %d\nOutput: %d\n\n", v[0], v[1], dldcount.Count(v[0], v[1]))
	}
}
