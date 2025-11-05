//# https://theweeklychallenge.org/blog/perl-weekly-challenge-346/
/*#

Task 1: Longest Parenthesis

Submitted by: [44]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string containing only ( and ).

   Write a script to find the length of the longest valid parenthesis.

Example 1

Input: $str = '(()())'
Output: 6

Valid Parenthesis: '(()())'

Example 2

Input: $str = ')()())'
Output: 4

Valid Parenthesis: '()()' at positions 1-4.

Example 3

Input: $str = '((()))()(((()'
Output: 8

Valid Parenthesis: '((()))()' at positions 0-7.

Example 4

Input: $str = '))))((()('
Output: 2

Valid Parenthesis: '()' at positions 6-7.

Example 5

Input: $str = '()(()'
Output: 2

Valid Parenthesis: '()' at positions 0-1 and 3-4.

Task 2: Magic Expression
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

func lp(s string) int {
	r := []rune(s)
	var c, mx int
	//fmt.Println(r)
	for i := range len(r) {
		//fmt.Println(r[:i+1])
		switch r[i] {
		case '(':
			c++
		default:
			c--
			if c < 0 {
				c = 0
			} else {
				j := i
				r[j] = 0
				for r[j] != '(' {
					j--
				}
				r[j] = 0
				for r[j] == 0 {
					j--
					if j < 0 {
						break
					}
				}
				d := i - j
				if mx < d {
					mx = d
				}
			}
		}
	}
	//fmt.Println(r, mx)
	return mx
}

func main() {
	for _, data := range []struct {
		input  string
		output int
	}{
		{"(()())", 6},
		{")()())", 4},
		{"((()))()(((()", 8},
		{"))))((()(", 2},
		{"()(()", 2},
		{"((()(()()", 4},
		{"((()(()())", 8},
		{"()(()()", 4},
		{"()(()())", 8},
	} {
		io.WriteString(os.Stdout, cmp.Diff(lp(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
