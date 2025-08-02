//# https://theweeklychallenge.org/blog/perl-weekly-challenge-332/
/*#

Task 2: Odd Letters

Submitted by: [40]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string.

   Write a script to find out if each letter in the given string appeared
   odd number of times.

Example 1

Input: $str = "weekly"
Output: false

w: 1 time
e: 2 times
k: 1 time
l: 1 time
y: 1 time

The letter 'e' appeared 2 times i.e. even.

Example 2

Input: $str = "perl"
Output: true

Example 3

Input: $source = "challenge"
Output: false
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 3rd August
   2025.
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

func ol(str string) bool {
	m := make(map[rune]int)
	for _, v := range str {
		m[v]++
	}
	for _, v := range m {
		if v%2 == 0 {
			return false
		}
	}
	return true
}

func main() {
	for _, data := range []struct {
		input  string
		output bool
	}{
		{"weekly", false},
		{"perl", true},
		{"challenge", false},
	} {
		io.WriteString(os.Stdout, cmp.Diff(ol(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
