//# https://theweeklychallenge.org/blog/perl-weekly-challenge-277/
/*#

Task 1: Count Common

Submitted by: [53]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given two array of strings, @words1 and @words2.

   Write a script to return the count of words that appears in both arrays
   exactly once.

Example 1

Input: @words1 = ("Perl", "is", "my", "friend")
       @words2 = ("Perl", "and", "Raku", "are", "friend")
Output: 2

The words "Perl" and "friend" appear once in each array.

Example 2

Input: @words1 = ("Perl", "and", "Python", "are", "very", "similar")
       @words2 = ("Python", "is", "top", "in", "guest", "languages")
Output: 1

Example 3

Input: @words1 = ("Perl", "is", "imperative", "Lisp", "is", "functional")
       @words2 = ("Crystal", "is", "similar", "to", "Ruby")
Output: 0

Task 2: Strong Pair
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

type words []string

func (wd words) removeMultiple() words {
	m := make(map[string]int)
	for _, v := range wd {
		m[v]++
	}
	var r words
	for k, v := range m {
		if v > 1 {
			continue
		}
		r = append(r, k)
	}
	return r
}

func (wd words) remainMultiple() words {
	m := make(map[string]int)
	for _, v := range wd {
		m[v]++
	}
	var r words
	for k, v := range m {
		if v > 1 {
			r = append(r, k)
		}
	}
	return r
}

func countCommon(words1, words2 words) int {
	return len(
		append(
			words1.removeMultiple(), words2.removeMultiple()...,
		).remainMultiple(),
	)
}

func main() {
	for _, data := range []struct {
		words1, words2 words
		count          int
	}{
		{words{"Perl", "is", "my", "friend"}, words{"Perl", "and", "Raku", "are", "friend"}, 2},
		{words{"Perl", "and", "Python", "are", "very", "similar"}, words{"Python", "is", "top", "in", "guest", "languages"}, 1},
		{words{"Perl", "is", "imperative", "Lisp", "is", "functional"}, words{"Crystal", "is", "similar", "to", "Ruby"}, 0},
	} {
		io.WriteString(os.Stdout, cmp.Diff(countCommon(data.words1, data.words2), data.count)) // blank if ok, otherwise show the difference
	}
}
