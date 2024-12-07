//# https://theweeklychallenge.org/blog/perl-weekly-challenge-295/
/*#

Task 1: Word Break

Submitted by: [44]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string, $str, and list of words, @words.

   Write a script to return true or false whether the given string can be
   segmented into a space separated sequence of one or more words from the
   given list.

Example 1

Input: $str = 'weeklychallenge', @words = ("challenge", "weekly")
Output: true

Example 2

Input: $str = "perlrakuperl", @words = ("raku", "perl")
Output: true

Example 3

Input: $str = "sonsanddaughters", @words = ("sons", "sand", "daughters")
Output: false

Task 2: Jump Game
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

func (ws words) wb(str string) bool {
	for _, w := range ws {
		if !strings.Contains(str, w) {
			return false
		}
		str = strings.ReplaceAll(str, w, "")
	}
	return str == ""
}

func main() {
	for _, data := range []struct {
		str    string
		words  words
		output bool
	}{
		{"weeklychallenge", words{"challenge", "weekly"}, true},
		{"perlrakuperl", words{"raku", "perl"}, true},
		{"sonsanddaughters", words{"sons", "sand", "daughters"}, false},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.words.wb(data.str), data.output)) // blank if ok, otherwise show the difference
	}
}
