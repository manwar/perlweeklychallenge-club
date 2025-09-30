//# https://theweeklychallenge.org/blog/perl-weekly-challenge-341/
/*#

Task 1: Broken Keyboard

Submitted by: [39]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string containing English letters only and also you are
   given broken keys.

   Write a script to return the total words in the given sentence can be
   typed completely.

Example 1

Input: $str = 'Hello World', @keys = ('d')
Output: 1

With broken key 'd', we can only type the word 'Hello'.

Example 2

Input: $str = 'apple banana cherry', @keys = ('a', 'e')
Output: 0

Example 3

Input: $str = 'Coding is fun', @keys = ()
Output: 3

No keys broken.

Example 4

Input: $str = 'The Weekly Challenge', @keys = ('a','b')
Output: 2

Example 5

Input: $str = 'Perl and Python', @keys = ('p')
Output: 1

Task 2: Reverse Prefix
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"strings"

	"github.com/google/go-cmp/cmp"
)

func bk(str string, keys []rune) int {
	l := len(keys)
	var cnt, i int
	for s := range strings.SplitSeq(strings.ToLower(str), " ") {
		for i = 0; i < l; i++ {
			if strings.ContainsRune(s, keys[i]) {
				break
			}
		}
		if i == l {
			cnt++
		}
	}
	return cnt
}

func main() {
	for _, data := range []struct {
		str    string
		keys   []rune
		output int
	}{
		{"Hello World", []rune{'d'}, 1},
		{"apple banana cherry", []rune{'a', 'e'}, 0},
		{"Coding is fun", []rune{}, 3},
		{"The Weekly Challenge", []rune{'a', 'b'}, 2},
		{"Perl and Python", []rune{'p'}, 1},
	} {
		io.WriteString(os.Stdout, cmp.Diff(bk(data.str, data.keys), data.output)) // blank if ok, otherwise show the difference
	}
}
