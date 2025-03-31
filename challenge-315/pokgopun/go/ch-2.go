//# https://theweeklychallenge.org/blog/perl-weekly-challenge-315/
/*#

Task 2: Find Third

Submitted by: [45]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a sentence and two words.

   Write a script to return all words in the given sentence that appear in
   sequence to the given two words.

Example 1

Input: $sentence = "Perl is a my favourite language but Python is my favourite t
oo."
       $first = "my"
       $second = "favourite"
Output: ("language", "too")

Example 2

Input: $sentence = "Barbie is a beautiful doll also also a beautiful princess."
       $first = "a"
       $second = "beautiful"
Output: ("doll", "princess")

Example 3

Input: $sentence = "we will we will rock you rock you.",
       $first = "we"
       $second = "will"
Output: ("we", "rock")
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 6th April 2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"strings"

	"github.com/google/go-cmp/cmp"
)

type input struct {
	sentence, first, second string
}

func (in input) process() []string {
	var (
		frst, scnd string
		res        []string
	)
	for str := range strings.SplitSeq(in.sentence, " ") {
		s := strings.Trim(str, ".,")
		switch {
		case scnd != "":
			if frst == in.first && scnd == in.second {
				res = append(res, s)
			}
			frst, scnd = scnd, s
		case frst == "":
			frst = s
		default:
			scnd = s
		}
	}
	return res
}

func main() {
	for _, data := range []struct {
		input  input
		output []string
	}{
		{input{"Perl is a my favourite language but Python is my favourite too.", "my", "favourite"}, []string{"language", "too"}},
		{input{"Barbie is a beautiful doll also also a beautiful princess.", "a", "beautiful"}, []string{"doll", "princess"}},
		{input{"we will we will rock you rock you.", "we", "will"}, []string{"we", "rock"}},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
