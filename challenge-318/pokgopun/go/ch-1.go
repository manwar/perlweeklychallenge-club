//# https://theweeklychallenge.org/blog/perl-weekly-challenge-318/
/*#

Task 1: Group Position

Submitted by: [42]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string of lowercase letters.

   Write a script to find the position of all groups in the given string.
   Three or more consecutive letters form a group. Return "” if none
   found.

Example 1

Input: $str = "abccccd"
Output: "cccc"

Example 2

Input: $str = "aaabcddddeefff"
Output: "aaa", "dddd", "fff"

Example 3

Input: $str = "abcdd"
Output: ""

Example 3

Input: @array = ("Morning", "Good")
       $word  = "MM"
Output: false

Task 2: Reverse Equals
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

type input string

type output []string

func (ot *output) add(b byte, count int) {
	if count < 3 {
		return
	}
	var bs []byte
	for count > 0 {
		bs = append(bs, b)
		count--
	}
	*ot = append(*ot, string(bs))
}

func (in input) process() output {
	var (
		char  byte
		count int
		otpt  output
	)
	for i := range len(in) {
		if char == in[i] {
			count++
		} else {
			otpt.add(char, count)
			char = in[i]
			count = 1
		}
	}
	otpt.add(char, count)
	if len(otpt) == 0 {
		return output{""}
	}
	return otpt
}

func main() {
	for _, data := range []struct {
		input  input
		output output
	}{
		{"abccccd", output{"cccc"}},
		{"aaabcddddeefff", output{"aaa", "dddd", "fff"}},
		{"abcdd", output{""}},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
