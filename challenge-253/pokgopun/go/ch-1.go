//# https://theweeklychallenge.org/blog/perl-weekly-challenge-253/
/*#

Task 1: Split Strings

Submitted by: [43]Mohammad S Anwar
     __________________________________________________________________

   You are given an array of strings and a character separator.

   Write a script to return all words separated by the given character
   excluding empty string.

Example 1

Input: @words = ("one.two.three","four.five","six")
       $separator = "."
Output: "one","two","three","four","five","six"

Example 2

Input: @words = ("$perl$$", "$$raku$")
       $separator = "$"
Output: "perl","raku"

Task 2: Weakest Row
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"strings"

	"github.com/google/go-cmp/cmp"
)

type words []string

func (ws words) split(sep string) words {
	var r words
	for _, v := range ws {
		for _, w := range strings.Split(v, sep) {
			if w != "" {
				r = append(r, w)
			}
		}
	}
	return r
}

func main() {
	for _, data := range []struct {
		wrds, otpt words
		sep        string
	}{
		{words{"one.two.three", "four.five", "six"}, words{"one", "two", "three", "four", "five", "six"}, "."},
		{words{"$perl$$", "$$raku$"}, words{"perl", "raku"}, "$"},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.wrds.split(data.sep), data.otpt)) //blank if ok, otherwise show the difference
	}
}
