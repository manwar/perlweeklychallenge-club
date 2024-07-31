//# https://theweeklychallenge.org/blog/perl-weekly-challenge-280/
/*#

Task 2: Count Asterisks

Submitted by: [54]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string, $str, where every two consecutive vertical bars
   are grouped into a pair.

   Write a script to return the number of asterisks, *, excluding any
   between each pair of vertical bars.

Example 1

Input: $str = "p|*e*rl|w**e|*ekly|"
Ouput: 2

The characters we are looking here are "p" and "w**e".

Example 2

Input: $str = "perl"
Ouput: 0

Example 3

Input: $str = "th|ewe|e**|k|l***ych|alleng|e"
Ouput: 5

The characters we are looking here are "th", "e**", "l***ych" and "e".
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 4th August
   2024.
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

func cntAtr(str string) int {
	a, b := byte('*'), byte('|')
	c := 0
	l := len(str)
	for l > 0 {
		l--
		switch str[l] {
		case a:
			c++
		case b:
			d := len(str[:l])
			for d > 0 {
				d--
				if str[d] == b {
					l = d
					break
				}
			}
		}
	}
	return c
}

func main() {
	for _, data := range []struct {
		input  string
		output int
	}{
		{"p|*e*rl|w**e|*ekly|", 2},
		{"perl", 0},
		{"th|ewe|e**|k|l***ych|alleng|e", 5},
	} {
		io.WriteString(os.Stdout, cmp.Diff(cntAtr(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
