//# https://theweeklychallenge.org/blog/perl-weekly-challenge-275/
/*#

Task 1: Broken Keys

Submitted by: [45]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a sentence, $sentence and list of broken keys @keys.

   Write a script to find out how many words can be typed fully.

Example 1

Input: $sentence = "Perl Weekly Challenge", @keys = ('l', 'a')
Output: 0

Example 2

Input: $sentence = "Perl and Raku", @keys = ('a')
Output: 1

Only Perl since the other word two words contain 'a' and can't be typed fully.

Example 3

Input: $sentence = "Well done Team PWC", @keys = ('l', 'o')
Output: 2

Example 4

Input: $sentence = "The joys of polyglottism", @keys = ('T')
Output: 2

Task 2: Replace Digits
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"strings"

	"github.com/google/go-cmp/cmp"
)

type chars []rune

func bk(st string, cs chars) int {
	words := strings.Split(st, " ")
	l := len(words)
	n := l
	var c rune
	for l > 0 {
		l--
		for _, c = range cs {
			if c >= 'A' && c <= 'Z' {
				c += 32
			}
			if strings.ContainsRune(strings.ToLower(words[l]), c) {
				n--
				break
			}
		}
	}
	return n
}

func main() {
	for _, data := range []struct {
		sentence string
		chars    chars
		count    int
	}{
		{"Perl Weekly Challenge", chars{'l', 'a'}, 0},
		{"Perl and Raku", chars{'a'}, 1},
		{"Well done Team PWC", chars{'l', 'o'}, 2},
		{"The joys of polyglottism", chars{'T'}, 2},
	} {
		io.WriteString(os.Stdout, cmp.Diff(bk(data.sentence, data.chars), data.count)) // blank if ok, otherwise show the differences
	}
}
