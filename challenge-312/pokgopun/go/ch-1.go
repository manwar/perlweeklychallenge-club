//# https://theweeklychallenge.org/blog/perl-weekly-challenge-312/
/*#

Task 1: Minimum Time

Submitted by: [52]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a typewriter with lowercase english letters a to z
   arranged in a circle.

   Task 1

   Typing a character takes 1 sec. You can move pointer one character
   clockwise or anti-clockwise.

   The pointer initially points at a.

   Write a script to return minimum time it takes to print the given
   string.

Example 1

Input: $str = "abc"
Output: 5

The pointer is at 'a' initially.
1 sec - type the letter 'a'
1 sec - move pointer clockwise to 'b'
1 sec - type the letter 'b'
1 sec - move pointer clockwise to 'c'
1 sec - type the letter 'c'

Example 2

Input: $str = "bza"
Output: 7

The pointer is at 'a' initially.
1 sec - move pointer clockwise to 'b'
1 sec - type the letter 'b'
1 sec - move pointer anti-clockwise to 'a'
1 sec - move pointer anti-clockwise to 'z'
1 sec - type the letter 'z'
1 sec - move pointer clockwise to 'a'
1 sec - type the letter 'a'

Example 3

Input: $str = "zjpc"
Output: 34

Task 2: Balls and Boxes
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

func mt(txt string) int {
	o := 'a'
	l := 'z' - o + 1
	c := 0
	var p rune = 0
	for _, n := range txt {
		if n < 'a' || n > 'z' {
			return -1
		}
		n -= o
		c++
		if p == n {
			continue
		}
		mn, mx := min(p, n), max(p, n)
		c += int(min(mx-mn, l-mx+mn))
		p = n
	}
	return c
}

func main() {
	for _, data := range []struct {
		input  string
		output int
	}{
		{"abc", 5},
		{"bza", 7},
		{"zjpc", 34},
	} {
		io.WriteString(os.Stdout, cmp.Diff(mt(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
