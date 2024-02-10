//# https://theweeklychallenge.org/blog/perl-weekly-challenge-255/
/*#

Task 1: Odd Character

Submitted by: [46]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given two strings, $s and $t. The string $t is generated using
   the shuffled characters of the string $s with an additional character.

   Write a script to find the additional character in the string $t..

Example 1

Input: $s = "Perl" $t = "Preel"
Output: "e"

Example 2

Input: $s = "Weekly" $t = "Weeakly"
Output: "a"

Example 3

Input: $s = "Box" $t = "Boxy"
Output: "y"

Task 2: Most Frequent Word
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

type str string

func (st str) oddChar(s str) rune {
	m := make(map[rune]int)
	for _, v := range st {
		m[v]++
	}
	for _, v := range s {
		if m[v] > 0 {
			m[v]--
		} else {
			return v
		}
	}
	return 0
}

func main() {
	for _, data := range []struct {
		s, t str
		o    rune
	}{
		{"Perl", "Preel", 'e'},
		{"Weekly", "Weeakly", 'a'},
		{"Box", "Boxy", 'y'},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.s.oddChar(data.t), data.o)) // blank if ok, otherwise show the difference
	}
}
