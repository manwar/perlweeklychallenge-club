package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

//# https://theweeklychallenge.org/blog/perl-weekly-challenge-317/
/*#

Task 1: Acronyms

Submitted by: [44]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of words and a word.

   Write a script to return true if concatenating the first letter of each
   word in the given array matches the given word, return false otherwise.

Example 1

Input: @array = ("Perl", "Weekly", "Challenge")
       $word  = "PWC"
Output: true

Example 2

Input: @array = ("Bob", "Charlie", "Joe")
       $word  = "BCJ"
Output: true

Example 3

Input: @array = ("Morning", "Good")
       $word  = "MM"
Output: false

Task 2: Friendly Strings
#*/
//# solution by pokgopun@gmail.com

type words []string

type input struct {
	ws words
	w  string
}

func (in input) process() bool {
	ws, w := in.ws, in.w
	l := len(ws)
	if l != len(w) {
		return false
	}
	for i := range l {
		if ws[i][0] != w[i] {
			return false
		}
	}
	return true
}

func main() {
	for _, data := range []struct {
		input  input
		output bool
	}{
		{input{words{"Perl", "Weekly", "Challenge"}, "PWC"}, true},
		{input{words{"Bob", "Charlie", "Joe"}, "BCJ"}, true},
		{input{words{"Morning", "Good"}, "MM"}, false},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
