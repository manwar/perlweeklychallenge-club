//# https://theweeklychallenge.org/blog/perl-weekly-challenge-365/
/*#

Task 1: Alphabet Index Digit Sum

Submitted by: [64]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string $str consisting of lowercase English letters,
   and an integer $k.

   Write a script to convert a lowercase string into numbers using
   alphabet positions (a=1 … z=26), concatenate them to form an integer,
   then compute the sum of its digits repeatedly $k times, returning the
   final value.

Example 1

Input: $str = "abc", $k = 1
Output: 6

Conversion: a = 1, b = 2, c = 3 -> 123
Digit sum: 1 + 2 + 3 = 6

Example 2

Input: $str = "az", $k = 2
Output: 9

Conversion: a = 1, z = 26 -> 126
1st sum: 1 + 2 + 6 = 9
2nd sum: 9

Example 3

Input: $str = "cat", $k = 1
Output: 6

Conversion: c = 3, a = 1, t = 20 -> 3120
Digit sum: 3 + 1 + 2 + 0 = 6

Example 4

Input: $str = "dog", $k = 2
Output: 8

Conversion: d = 4, o = 15, g = 7 -> 4157
1st sum: 4 + 1 + 5 + 7 = 17
2nd sum: 1 + 7 = 8

Example 5

Input: $str = "perl", $k = 3
Output: 6

Conversion: p = 16, e = 5, r = 18, l = 12 -> 1651812
1st sum: 1 + 6 + 5 + 1 + 8 + 1 + 2 = 24
2nd sum: 2+4 = 6
3rd sum: 6

Task 2: Valid Token Counter
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"strconv"

	"github.com/google/go-cmp/cmp"
)

type input string

func (in input) process(k int) int {
	n := in.convert('a' - 1)
	for n > 9 && k > 0 {
		k--
		n = input(strconv.Itoa(n)).convert('0')
	}
	return n
}

func (in input) convert(r rune) int {
	n := 0
	for _, v := range in {
		n += int(v - r)
	}
	return n
}

func main() {
	for _, data := range []struct {
		str       input
		k, output int
	}{
		{"abc", 1, 6},
		{"az", 2, 9},
		{"cat", 1, 6},
		{"dog", 2, 8},
		{"perl", 3, 6},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.str.process(data.k), data.output)) // blank if ok, otherwise show the difference
	}
}
