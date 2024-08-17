//# https://theweeklychallenge.org/blog/perl-weekly-challenge-279/
/*#

Task 1: Sort Letters

Submitted by: [45]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given two arrays, @letters and @weights.

   Write a script to sort the given array @letters based on the @weights.

Example 1

Input: @letters = ('R', 'E', 'P', 'L')
       @weights = (3, 2, 1, 4)
Output: PERL

Example 2

Input: @letters = ('A', 'U', 'R', 'K')
       @weights = (2, 4, 1, 3)
Output: RAKU

Example 3

Input: @letters = ('O', 'H', 'Y', 'N', 'P', 'T')
       @weights = (5, 4, 2, 6, 1, 3)
Output: PYTHON

Task 2: Split String
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

func sortLetters(letters []rune, weights []int) string {
	r := make([]rune, len(letters))
	for i, v := range letters {
		r[weights[i]-1] = v
	}
	return string(r)
}

func main() {
	for _, data := range []struct {
		letters []rune
		weights []int
		output  string
	}{
		{[]rune{'R', 'E', 'P', 'L'}, []int{3, 2, 1, 4}, "PERL"},
		{[]rune{'A', 'U', 'R', 'K'}, []int{2, 4, 1, 3}, "RAKU"},
		{[]rune{'O', 'H', 'Y', 'N', 'P', 'T'}, []int{5, 4, 2, 6, 1, 3}, "PYTHON"},
	} {
		io.WriteString(os.Stdout, cmp.Diff(sortLetters(data.letters, data.weights), data.output)) // blank if ok otherwise show the difference
	}
}
