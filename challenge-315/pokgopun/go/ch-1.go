//# https://theweeklychallenge.org/blog/perl-weekly-challenge-315/
/*#

Task 1: Find Words

Submitted by: [44]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a list of words and a character.

   Write a script to return the index of word in the list where you find
   the given character.

Example 1

Input: @list = ("the", "weekly", "challenge")
       $char = "e"
Output: (0, 1, 2)

Example 2

Input: @list = ("perl", "raku", "python")
       $char = "p"
Output: (0, 2)

Example 3

Input: @list = ("abc", "def", "bbb", "bcd")
       $char = "b"
Output: (0, 2, 3)

Task 2: Find Third
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

type input struct {
	s []string
	c rune
}

func (in input) process() []int {
	var ints []int
	for i := range len(in.s) {
		for _, r := range in.s[i] {
			if r == in.c {
				ints = append(ints, i)
				break
			}
		}
	}
	return ints
}

func main() {
	for _, data := range []struct {
		input  input
		output []int
	}{
		{input{[]string{"the", "weekly", "challenge"}, 'e'}, []int{0, 1, 2}},
		{input{[]string{"perl", "raku", "python"}, 'p'}, []int{0, 2}},
		{input{[]string{"abc", "def", "bbb", "bcd"}, 'b'}, []int{0, 2, 3}},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
