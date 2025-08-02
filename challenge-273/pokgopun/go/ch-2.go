//# https://theweeklychallenge.org/blog/perl-weekly-challenge-273/
/*#

Task 2: B After A

Submitted by: [53]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string, $str.

   Write a script to return true if there is at least one b, and no a
   appears after the first b.

Example 1

Input: $str = "aabb"
Output: true

Example 2

Input: $str = "abab"
Output: false

Example 3

Input: $str = "aaa"
Output: false

Example 4

Input: $str = "bbb"
Output: true
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 16th June 2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

func aAfterB(str string) bool {
	for i, v := range str {
		if v == 'b' {
			for _, c := range str[i+1:] {
				if c == 'a' {
					return false
				}
				return true
			}
		}
	}
	return false
}

func main() {
	for _, data := range []struct {
		str string
		res bool
	}{
		{"aabb", true},
		{"abab", false},
		{"aaa", false},
		{"bbb", true},
	} {
		io.WriteString(os.Stdout, cmp.Diff(aAfterB(data.str), data.res)) // blank if ok, otherwise show the differences
	}
}
