//# https://theweeklychallenge.org/blog/perl-weekly-challenge-256/
/*#

Task 1: Maximum Pairs

Submitted by: [41]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of distinct words, @words.

   Write a script to find the maximum pairs in the given array. The words
   $words[i] and $words[j] can be a pair one is reverse of the other.

Example 1

Input: @words = ("ab", "de", "ed", "bc")
Output: 1

There is one pair in the given array: "de" and "ed"

Example 2

Input: @words = ("aa", "ba", "cd", "ed")
Output: 0

Example 3

Input: @words = ("uv", "qp", "st", "vu", "mn", "pq"))
Output: 2

Task 2: Merge Strings
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"slices"

	"github.com/google/go-cmp/cmp"
)

type str string

func (s str) reverse() str {
	r := []rune(s)
	slices.Reverse(r)
	return str(r)
}

type strs []str

func (st strs) maxPair() int {
	l := len(st)
	var c, i int
	for i < l-1 {
		for _, v := range st[i+1:] {
			if st[i] == v.reverse() {
				c++
			}
		}
		i++
	}
	return c
}

func main() {
	for _, data := range []struct {
		input  strs
		output int
	}{
		{strs{"ab", "de", "ed", "bc"}, 1},
		{strs{"aa", "ba", "cd", "ed"}, 0},
		{strs{"uv", "qp", "st", "vu", "mn", "pq"}, 2},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.maxPair(), data.output)) // blank if ok, otherwise show the difference
	}
}
