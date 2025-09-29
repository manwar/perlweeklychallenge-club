//# https://theweeklychallenge.org/blog/perl-weekly-challenge-341/
/*#

Task 2: Reverse Prefix

Submitted by: [40]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string, $str and a character in the given string,
   $char.

   Write a script to reverse the prefix upto the first occurrence of the
   given $char in the given string $str and return the new string.

Example 1

Input: $str = "programming", $char = "g"
Output: "gorpramming"

Reverse of prefix "prog" is "gorp".

Example 2

Input: $str = "hello", $char = "h"
Output: "hello"

Example 3

Input: $str = "abcdefghij", $char = "h"
Output: "hgfedcbaij"

Example 4

Input: $str = "reverse", $char = "s"
Output: "srevere"

Example 5

Input: $str = "perl", $char = "r"
Output: "repl"
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 5th October
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"slices"
	"strings"

	"github.com/google/go-cmp/cmp"
)

func rp(s string, r rune) string {
	i := strings.IndexRune(s, r)
	if i < 1 {
		return s
	}
	prfx := []rune(s[:i+1])
	slices.Reverse(prfx)
	return string(prfx) + s[i+1:]
}

func main() {
	for _, data := range []struct {
		str    string
		char   rune
		output string
	}{
		{"programming", 'g', "gorpramming"},
		{"hello", 'h', "hello"},
		{"abcdefghij", 'h', "hgfedcbaij"},
		{"reverse", 's', "srevere"},
		{"perl", 'r', "repl"},
	} {
		io.WriteString(os.Stdout, cmp.Diff(rp(data.str, data.char), data.output)) // blank if ok, otherwise show the difference
	}
}
