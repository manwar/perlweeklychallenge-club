//# https://theweeklychallenge.org/blog/perl-weekly-challenge-272/
/*#

Task 2: String Score

Submitted by: [46]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string, $str.

   Write a script to return the score of the given string.

     The score of a string is defined as the sum of the absolute
     difference between the ASCII values of adjacent characters.

Example 1

Input: $str = "hello"
Output: 13

ASCII values of characters:
h = 104
e = 101
l = 108
l = 108
o = 111

Score => |104 - 101| + |101 - 108| + |108 - 108| + |108 - 111|
      => 3 + 7 + 0 + 3
      => 13

Example 2

Input: "perl"
Output: 30

ASCII values of characters:
p = 112
e = 101
r = 114
l = 108

Score => |112 - 101| + |101 - 114| + |114 - 108|
      => 11 + 13 + 6
      => 30

Example 3

Input: "raku"
Output: 37

ASCII values of characters:
r = 114
a = 97
k = 107
u = 117

Score => |114 - 97| + |97 - 107| + |107 - 117|
      => 17 + 10 + 10
      => 37
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 9th June 2024.
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

func ss(str string) int {
	var c int
	for i := range len(str) - 1 {
		c += int(max(str[i], str[i+1]) - min(str[i], str[i+1]))
	}
	return c
}

func main() {
	for _, data := range []struct {
		input  string
		output int
	}{
		{"hello", 13},
		{"perl", 30},
		{"raku", 37},
	} {
		io.WriteString(os.Stdout, cmp.Diff(ss(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
