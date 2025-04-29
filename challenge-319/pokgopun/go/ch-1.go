//# https://theweeklychallenge.org/blog/perl-weekly-challenge-319/
/*#

Task 1: Word Count

Submitted by: [46]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a list of words containing alphabetic characters only.

   Write a script to return the count of words either starting with a
   vowel or ending with a vowel.

Example 1

Input: @list = ("unicode", "xml", "raku", "perl")
Output: 2

The words are "unicode" and "raku".

Example 2

Input: @list = ("the", "weekly", "challenge")
Output: 2

Example 3

Input: @list = ("perl", "python", "postgres")
Output: 0

Task 2: Minimum Common
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

type words []word

func (ws words) wc() int {
	c := 0
	for _, v := range ws {
		if v.charIsVowel(0) {
			c++
		} else {
			l := len(v)
			if v.charIsVowel(l - 1) {
				c++
			}
		}
	}
	return c
}

type word string

func (w word) charIsVowel(i int) bool {
	c := []rune(w)[i]
	if c >= 'A' && c <= 'Z' {
		c += 'a' - 'A'
	}
	for _, r := range "aeiuo" {
		if r == c {
			return true
		}
	}
	return false
}

func main() {
	for _, data := range []struct {
		input  words
		output int
	}{
		{words{"unicode", "xml", "raku", "perl"}, 2},
		{words{"the", "weekly", "challenge"}, 2},
		{words{"perl", "python", "postgres"}, 0},
		{words{"Unicode", "xml", "rakU", "perl"}, 2},
		{words{"thE", "weekly", "challengE"}, 2},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.wc(), data.output)) // blank if ok, otherwise show the differences
	}
}
