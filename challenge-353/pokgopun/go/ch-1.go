//# https://theweeklychallenge.org/blog/perl-weekly-challenge-353/
/*#

Task 1: Max Words

Submitted by: [73]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of sentences.

   Write a script to return the maximum number of words that appear in a
   single sentence.

Example 1

Input: @sentences = ("Hello world", "This is a test", "Perl is great")
Output: 4

Example 2

Input: @sentences = ("Single")
Output: 1

Example 3

Input: @sentences = ("Short", "This sentence has six words in total", "A B C", "
Just four words here")
Output: 6

Example 4

Input: @sentences = ("One", "Two parts", "Three part phrase", "")
Output: 3

Example 5

Input: @sentences = ("The quick brown fox jumps over the lazy dog", "A", "She se
lls seashells by the seashore", "To be or not to be that is the question")
Output: 10

Task 2: Validate Coupon
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

type strings []string

func (ss strings) process() int {
	mx := 0
	for _, v := range ss {
		cnt := 1
		for _, c := range v {
			if c == ' ' {
				cnt++
			}
		}
		if mx < cnt {
			mx = cnt
		}
	}
	return mx
}

func main() {
	for _, data := range []struct {
		input  strings
		output int
	}{
		{strings{"Hello world", "This is a test", "Perl is great"}, 4},
		{strings{"Single"}, 1},
		{strings{"Short", "This sentence has six words in total", "A B C", "Just four words here"}, 7},
		{strings{"One", "Two parts", "Three part phrase", ""}, 3},
		{strings{"The quick brown fox jumps over the lazy dog", "A", "She sells seashells by the seashore", "To be or not to be that is the question"}, 10},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
