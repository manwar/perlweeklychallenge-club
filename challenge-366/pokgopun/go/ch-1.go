//# https://theweeklychallenge.org/blog/perl-weekly-challenge-366/
/*#

Task 1: Count Prefixes

Submitted by: [67]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of words and a string (contains only lowercase
   English letters).

   Write a script to return the number of words in the given array that
   are a prefix of the given string.

Example 1

Input: @array = ("a", "ap", "app", "apple", "banana"), $str = "apple"
Output: 4

Example 2

Input: @array = ("cat", "dog", "fish"), $str = "bird"
Output: 0

Example 3

Input: @array = ("hello", "he", "hell", "heaven", "he"), $str = "hello"
Output: 4

Example 4

Input: @array = ("", "code", "coding", "cod"), $str = "coding"
Output: 3

Example 5

Input: @array = ("p", "pr", "pro", "prog", "progr", "progra", "program"), $str =
 "program"
Output: 7

Task 2: Valid Times
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"strings"

	"github.com/google/go-cmp/cmp"
)

type strs []string

func (ss strs) process(str string) int {
	c := 0
	for _, v := range ss {
		if strings.HasPrefix(str, v) {
			c++
		}
	}
	return c
}

func main() {
	for _, data := range []struct {
		array  strs
		str    string
		output int
	}{
		{strs{"a", "ap", "app", "apple", "banana"}, "apple", 4},
		{strs{"cat", "dog", "fish"}, "bird", 0},
		{strs{"hello", "he", "hell", "heaven", "he"}, "hello", 4},
		{strs{"", "code", "coding", "cod"}, "coding", 3},
		{strs{"p", "pr", "pro", "prog", "progr", "progra", "program"}, "program", 7},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.array.process(data.str), data.output)) // blank if ok, otherwise show the difference
	}
}
