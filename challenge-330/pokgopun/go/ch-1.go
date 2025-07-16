//# https://theweeklychallenge.org/blog/perl-weekly-challenge-330/
/*#

Task 1: Clear Digits

Submitted by: [44]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string containing only lower case English letters and
   digits.

   Write a script to remove all digits by removing the first digit and the
   closest non-digit character to its left.

Example 1

Input: $str = "cab12"
Output: "c"

Round 1: remove "1" then "b" => "ca2"
Round 2: remove "2" then "a" => "c"

Example 2

Input: $str = "xy99"
Output: ""

Round 1: remove "9" then "y" => "x9"
Round 2: remove "9" then "x" => ""

Example 3

Input: $str = "pa1erl"
Output: "perl"

Task 2: Title Capital
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"regexp"

	"github.com/google/go-cmp/cmp"
)

func cd(str string) string {
	re := regexp.MustCompile(`([a-z])(\d*?)(\d)`)
	for {
		s := re.ReplaceAllString(str, "${2}")
		if s == str {
			break
		}
		str = s
	}
	return str
}

func main() {
	for _, data := range []struct {
		input, output string
	}{
		{"cab12", "c"},
		{"xy99", ""},
		{"pa1erl", "perl"},
	} {
		io.WriteString(os.Stdout, cmp.Diff(cd(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
