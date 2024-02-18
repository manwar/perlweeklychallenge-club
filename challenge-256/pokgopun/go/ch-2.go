//# https://theweeklychallenge.org/blog/perl-weekly-challenge-256/
/*#

Task 2: Merge Strings

Submitted by: [42]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given two strings, $str1 and $str2.

   Write a script to merge the given strings by adding in alternative
   order starting with the first string. If a string is longer than the
   other then append the remaining at the end.

Example 1

Input: $str1 = "abcd", $str2 = "1234"
Output: "a1b2c3d4"

Example 2

Input: $str1 = "abc", $str2 = "12345"
Output: "a1b2c345"

Example 3

Input: $str1 = "abcde", $str2 = "123"
Output: "a1b2c3de"
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 18th February
   2024.
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

type strPair struct {
	str1, str2 string
}

func (sp strPair) merge() string {
	l1 := len(sp.str1)
	l2 := len(sp.str2)
	l := max(l1, l2)
	var b strings.Builder
	for i := 0; i < l; i++ {
		if i < l1 {
			b.WriteByte(sp.str1[i])
		}
		if i < l2 {
			b.WriteByte(sp.str2[i])
		}
	}
	return b.String()
}

func main() {
	for _, data := range []struct {
		input  strPair
		output string
	}{
		{strPair{"abcd", "1234"}, "a1b2c3d4"},
		{strPair{"abc", "12345"}, "a1b2c345"},
		{strPair{"abcde", "123"}, "a1b2c3de"},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.merge(), data.output)) // blank if ok, otherwise show the difference
	}
}
