//# https://theweeklychallenge.org/blog/perl-weekly-challenge-367/
/*#

Task 1: Max Odd Binary

Submitted by: [61]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a binary string that has at least one ‘1’.

   Write a script to rearrange the bits in such a way that the resulting
   binary number is the maximum odd binary number and return the resulting
   binary string. The resulting string can have leading zeros.

Example 1

Input: $str = "1011"
Output: "1101"

"1101" is max odd binary (13).

Example 2

Input: $str = "100"
Output: "001"

"001" is max odd binary (1).

Example 3

Input: $str = "111000"
Output: "110001"

Example 4

Input: $str = "0101"
Output: "1001"

Example 5

Input: $str = "1111"
Output: "1111"

Task 2: Conflict Events
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"strings"

	"github.com/google/go-cmp/cmp"
)

func mob(str string) string {
	c := 0
	for _, v := range str {
		if v == '1' {
			c++
		}
	}
	l := len(str)
	if c == 0 || c == l {
		return str
	}
	d := l - c
	var b strings.Builder
	for c > 1 {
		c--
		b.WriteByte('1')
	}
	for d > 0 {
		d--
		b.WriteByte('0')
	}
	b.WriteByte('1')
	return b.String()
}

func main() {
	for _, data := range []struct {
		input, output string
	}{
		{"1011", "1101"},
		{"100", "001"},
		{"111000", "110001"},
		{"0101", "1001"},
		{"1111", "1111"},
	} {
		io.WriteString(os.Stdout, cmp.Diff(mob(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
