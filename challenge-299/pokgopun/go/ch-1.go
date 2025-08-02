//# https://theweeklychallenge.org/blog/perl-weekly-challenge-299/
/*#

Task 1: Replace Words

Submitted by: [49]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of words and a sentence.

   Write a script to replace all words in the given sentence that start
   with any of the words in the given array.

Example 1

Input: @words = ("cat", "bat", "rat")
       $sentence = "the cattle was rattle by the battery"
Output: "the cat was rat by the bat"

Example 2

Input: @words = ("a", "b", "c")
       $sentence = "aab aac and cac bab"
Output: "a a a c b"

Example 3

Input: @words = ("man", "bike")
       $sentence = "the manager was hit by a biker"
Output: "the man was hit by a bike"

Task 2: Word Search
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"strings"

	"github.com/google/go-cmp/cmp"
)

type words []string

func (ws words) rw(sentence string) string {
	s := strings.Split(sentence, " ")
	for _, w := range ws {
		for i := range len(s) {
			if strings.HasPrefix(s[i], w) {
				s[i] = w
			}
		}
	}
	return strings.Join(s, " ")
}

func main() {
	for _, data := range []struct {
		words            words
		sentence, output string
	}{
		{words{"cat", "bat", "rat"}, "the cattle was rattle by the battery", "the cat was rat by the bat"},
		{words{"a", "b", "c"}, "aab aac and cac bab", "a a a c b"},
		{words{"man", "bike"}, "the manager was hit by a biker", "the man was hit by a bike"},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.words.rw(data.sentence), data.output)) // blank if ok, otherwise show the difference
	}
}
