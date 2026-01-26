//# https://theweeklychallenge.org/blog/perl-weekly-challenge-358/
/*#

Task 2: Encrypted String

Submitted by: [48]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string $str and an integer $int.

   Write a script to encrypt the string using the algorithm - for each
   character $char in $str, replace $char with the $int th character after
   $char in the alphabet, wrapping if needed and return the encrypted
   string.

Example 1

Input: $str = "abc", $int = 1
Output: "bcd"

Example 2

Input: $str = "xyz", $int = 2
Output: "zab"

Example 3

Input: $str = "abc", $int = 27
Output: "bcd"

Example 4

Input: $str = "hello", $int = 5
Output: "mjqqt"

Example 5

Input: $str = "perl", $int = 26
Output: "perl"
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 1st February
   2026.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com
package main

import (
	"io"
	"os"
	"strings"

	"github.com/google/go-cmp/cmp"
)

func es(str string, n int) string {
	var b strings.Builder
	for _, v := range str {
		b.WriteRune(((v-'a')+rune(n)%26)%26 + 'a')
	}
	return b.String()
}

func main() {
	for _, data := range []struct {
		str    string
		n      int
		output string
	}{
		{"abc", 1, "bcd"},
		{"xyz", 2, "zab"},
		{"abc", 27, "bcd"},
		{"hello", 5, "mjqqt"},
		{"perl", 26, "perl"},
	} {
		io.WriteString(os.Stdout, cmp.Diff(es(data.str, data.n), data.output)) // blank if ok, otherwise show the difference
	}
}
