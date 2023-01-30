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
	"sort"
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
	m := make(map[string]struct{})

	fmt.Printf("Input: n = %d\nOutput: %d\n\nThere are %[2]d ways of stacking %[1]d pennies in ascending piles\n\n", n, penny(m, n))
	var b strings.Builder
	for k := range m {
		b.WriteString("\t" + k + "\n")
	}
	io.WriteString(os.Stdout, b.String())
}

func penny(m map[string]struct{}, n ...uint64) int {
	last := n[len(n)-1]
	if last > 0 {
		s := make([]uint64, len(n)+1)
		copy(s, n)
		for i := uint64(1); i <= last; i++ {
			s[len(s)-2] = i
			s[len(s)-1] = last - i
			penny(m, s...)
		}
	} else if len(n) > 1 {
		sort.SliceStable(n, func(i, j int) bool {
			return n[i] < n[j]
		})
		var b strings.Builder
		for _, v := range n[1:] {
			b.WriteString(strconv.FormatUint(v, 10) + " ")
		}
		m[b.String()] = struct{}{}
	}
	return len(m)
}
