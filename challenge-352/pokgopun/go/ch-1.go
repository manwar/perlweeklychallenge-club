//# https://theweeklychallenge.org/blog/perl-weekly-challenge-352/
/*#

Task 1: Match String

Submitted by: [67]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of strings.

   Write a script to return all strings that are a substring of another
   word in the given array in the order they occur.

Example 1

Input: @words = ("cat", "cats", "dog", "dogcat", "dogcat", "rat", "ratcatdogcat"
)
Output: ("cat", "dog", "dogcat", "rat")

Example 2

Input: @words = ("hello", "hell", "world", "wor", "ellow", "elloworld")
Output: ("hell", "world", "wor", "ellow")

Example 3

Input: @words = ("a", "aa", "aaa", "aaaa")
Output: ("a", "aa", "aaa")

Example 4

Input: @words = ("flower", "flow", "flight", "fl", "fli", "ig", "ght")
Output: ("flow", "fl", "fli", "ig", "ght")

Example 5

Input: @words = ("car", "carpet", "carpenter", "pet", "enter", "pen", "pent")
Output: ("car", "pet", "enter", "pen", "pent")

Task 2: Binary Prefix
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

type strs []string

func (ss strs) process() strs {
	var m strs
	for i, s := range ss {
		for j, p := range ss {
			if i != j && strings.Contains(p, s) && !slices.Contains(m, s) {
				m = append(m, s)
				break
			}
		}
	}
	return m
}

func main() {
	for _, data := range []struct {
		input, output strs
	}{
		{strs{"cat", "cats", "dog", "dogcat", "dogcat", "rat", "ratcatdogcat"}, strs{"cat", "dog", "dogcat", "rat"}},
		{strs{"hello", "hell", "world", "wor", "ellow", "elloworld"}, strs{"hell", "world", "wor", "ellow"}},
		{strs{"a", "aa", "aaa", "aaaa"}, strs{"a", "aa", "aaa"}},
		{strs{"flower", "flow", "flight", "fl", "fli", "ig", "ght"}, strs{"flow", "fl", "fli", "ig", "ght"}},
		{strs{"car", "carpet", "carpenter", "pet", "enter", "pen", "pent"}, strs{"car", "pet", "enter", "pen", "pent"}},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
