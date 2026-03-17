//# https://theweeklychallenge.org/blog/perl-weekly-challenge-364/
/*#

Task 1: Decrypt String

Submitted by: [65]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string formed by digits and ‘#'.

   Write a script to map the given string to English lowercase characters
   following the given rules.
- Characters 'a' to 'i' are represented by '1' to '9' respectively.
- Characters 'j' to 'z' are represented by '10#' to '26#' respectively.

Example 1

Input: $str = "10#11#12"
Output: "jkab"

10# -> j
11# -> k
1   -> a
2   -> b

Example 2

Input: $str = "1326#"
Output: "acz"

1   -> a
3   -> c
26# -> z

Example 3

Input: $str = "25#24#123"
Output: "yxabc"

25# -> y
24# -> x
1   -> a
2   -> b
3   -> c

Example 4

Input: $str = "20#5"
Output: "te"

20# -> t
5   -> e

Example 5

Input: $str = "1910#26#"
Output: "aijz"

1   -> a
9   -> i
10# -> j
26# -> z

Task 2: Goal Parser
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"regexp"
	"strings"

	"github.com/google/go-cmp/cmp"
)

func myPattern() *regexp.Regexp {
	var b strings.Builder
	var n byte = 26
	for n > 9 {
		b.WriteByte(48 + n/10)
		b.WriteByte(48 + n%10)
		b.WriteString("#|")
		n--
	}
	for n > 0 {
		b.WriteByte(48 + n)
		b.WriteRune('|')
		n--
	}
	return regexp.MustCompile(b.String()[:b.Len()-1])
}

func main() {
	rgx := myPattern()
	f := func(str string) string {
		var (
			b    strings.Builder
			c    byte
			i, j int
		)
		for {
			loc := rgx.FindStringIndex(str[i:])
			if loc == nil {
				break
			}
			j = loc[1]
			c = str[i] - 48
			if j > 1 {
				c = 10*c + str[i+1] - 48
			}
			b.WriteByte(c + 96)
			i += j
		}
		return b.String()
	}
	for _, data := range []struct {
		input, output string
	}{
		{"10#11#12", "jkab"},
		{"1326#", "acz"},
		{"25#24#123", "yxabc"},
		{"20#5", "te"},
		{"1910#26#", "aijz"},
	} {
		io.WriteString(os.Stdout, cmp.Diff(f(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
