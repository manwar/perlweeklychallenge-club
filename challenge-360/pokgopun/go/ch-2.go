//# https://theweeklychallenge.org/blog/perl-weekly-challenge-360/
/*#

Task 2: Word Sorter

Submitted by: [47]Mohammad Sajid Anwar
     __________________________________________________________________

   You are give a sentence.

   Write a script to order words in the given sentence alphabetically but
   keeps the words themselves unchanged.

Example 1

Input: $str = "The quick brown fox"
Output: "brown fox quick The"

Example 2

Input: $str = "Hello    World!   How   are you?"
Output: "are Hello How World! you?"

Example 3

Input: $str = "Hello"
Output: "Hello"

Example 4

Input: $str = "Hello, World! How are you?"
Output: "are Hello, How World! you?"

Example 5

Input: $str = "I have 2 apples and 3 bananas!"
Output: "2 3 and apples bananas! have I"
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 14th February
   2026.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"slices"
	"strings"

	"github.com/google/go-cmp/cmp"
)

func wordSorter(str string) string {
	/*
		words := bytes.Fields([]byte(str))
		slices.SortFunc(words, func(a, b []byte) int {
			return bytes.Compare(bytes.ToLower(a), bytes.ToLower(b))
		})
		return string(bytes.Join(words, []byte{' '}))
	*/
	words := strings.Fields(str)
	slices.SortFunc(words, func(a, b string) int {
		return strings.Compare(strings.ToLower(a), strings.ToLower(b))
	})
	return strings.Join(words, " ")
}

func main() {
	for _, data := range []struct {
		input, output string
	}{
		{"The quick brown fox", "brown fox quick The"},
		{"Hello    World!   How   are you?", "are Hello How World! you?"},
		{"Hello", "Hello"},
		{"Hello, World! How are you?", "are Hello, How World! you?"},
		{"I have 2 apples and 3 bananas!", "2 3 and apples bananas! have I"},
	} {
		io.WriteString(os.Stdout, cmp.Diff(wordSorter(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
