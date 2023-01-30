/*
	https://theweeklychallenge.org/blog/perl-weekly-challenge-201/

Task 2: Penny Piles
Submitted by: Robbie Hatley
You are given an integer, $n > 0.

Write a script to determine the number of ways of putting $n pennies in a row of piles of ascending heights from left to right.

Example
Input: $n = 5
Output: 7

Since $n=5, there are 7 ways of stacking 5 pennies in ascending piles:

	1 1 1 1 1
	1 1 1 2
	1 2 2
	1 1 3
	2 3
	1 4
	5
*/
package main

import (
	"fmt"
	"io"
	"log"
	"os"
	"strconv"
	"strings"
)

func main() {
	var (
		n   uint64 = 5
		err error
	)
	if len(os.Args) > 1 {
		n, err = strconv.ParseUint(os.Args[1], 10, 64)
		if err != nil {
			log.Fatal(err)
		}
	}
	var b strings.Builder
	fmt.Printf("Input: n = %d\nOutput: %d\n\nThere are %[2]d ways of stacking %[1]d pennies in ascending piles\n\n", n, penny(&b, n))
	io.WriteString(os.Stdout, b.String())
}

func penny(b *strings.Builder, n ...uint64) int {
	last := n[len(n)-1]
	if last > 0 {
		s := make([]uint64, len(n)+1)
		copy(s, n)
		var first uint64 = 1
		if len(n) > 1 {
			first = n[len(n)-2]
		}
		for i := first; i <= last; i++ {
			s[len(s)-2] = i
			s[len(s)-1] = last - i
			penny(b, s...)
		}
	} else if len(n) > 1 {
		for _, v := range n[:len(n)-1] {
			b.WriteString(strconv.FormatUint(v, 10) + " ")
		}
		b.WriteRune('\n')
	}
	return strings.Count(b.String(), "\n")
}
