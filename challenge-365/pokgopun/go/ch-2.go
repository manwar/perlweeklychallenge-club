//# https://theweeklychallenge.org/blog/perl-weekly-challenge-365/
/*#

Task 2: Valid Token Counter

Submitted by: [65]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a sentence.

   Write a script to split the given sentence into space-separated tokens
   and count how many are valid words. A token is valid if it contains no
   digits, has at most one hyphen surrounded by lowercase letters, and at
   most one punctuation mark (!, ., ,) appearing only at the end.

Example 1

Input: $str = "cat and dog"
Output: 3

Tokens: "cat", "and", "dog"

Example 2

Input: $str = "a-b c! d,e"
Output: 2

Tokens: "a-b", "c!", "d,e"
"a-b" -> valid (one hyphen between letters)
"c!"  -> valid (punctuation at end)
"d,e" -> invalid (punctuation not at end)

Example 3

Input: $str = "hello-world! this is fun"
Output: 4

Tokens: "hello-world!", "this", "is", "fun"
All satisfy the rules.

Example 4

Input: $str = "ab- cd-ef gh- ij!"
Output: 2

Tokens: "ab-", "cd-ef", "gh-", "ij!"
"ab-"   -> invalid (hyphen not surrounded by letters)
"cd-ef" -> valid
"gh-"   -> invalid
"ij!"   -> valid

Example 5

Input: $str = "wow! a-b-c nice."
Output: 2

Tokens: "wow!", "a-b-c", "nice."
"wow!"  -> valid
"a-b-c" -> invalid (more than one hyphen)
"nice." -> valid
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 22nd March
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

func main() {
	pattern := regexp.MustCompile("^(?:[a-z]+-)?[a-z]+[?!.,]?$")
	f := func(str string) int {
		c := 0
		for v := range strings.FieldsSeq(str) {
			if pattern.MatchString(v) {
				c++
			}
		}
		return c
	}
	for _, data := range []struct {
		input  string
		output int
	}{
		{"cat and dog", 3},
		{"a-b c! d,e", 2},
		{"hello-world! this is fun", 4},
		{"ab- cd-ef gh- ij!", 2},
		{"wow! a-b-c nice.", 2},
	} {
		io.WriteString(os.Stdout, cmp.Diff(f(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
