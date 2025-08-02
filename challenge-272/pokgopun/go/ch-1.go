//# https://theweeklychallenge.org/blog/perl-weekly-challenge-272/
/*#

Task 1: Defang IP Address

Submitted by: [45]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a valid IPv4 address.

   Write a script to return the defanged version of the given IP address.

     A defanged IP address replaces every period “.” with “[.]".

Example 1

Input: $ip = "1.1.1.1"
Output: "1[.]1[.]1[.]1"

Example 2

Input: $ip = "255.101.1.0"
Output: "255[.]101[.]1[.]0"

Task 2: String Score
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

func dfip(str string) string {
	var rs []rune
	for _, v := range str {
		if v == '.' {
			rs = append(rs, '[', '.', ']')
		} else {
			rs = append(rs, v)
		}
	}
	return string(rs)
}

func main() {
	for _, data := range []struct {
		input, output string
	}{
		{"1.1.1.1", "1[.]1[.]1[.]1"},
		{"255.101.1.0", "255[.]101[.]1[.]0"},
	} {
		io.WriteString(os.Stdout, cmp.Diff(dfip(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
