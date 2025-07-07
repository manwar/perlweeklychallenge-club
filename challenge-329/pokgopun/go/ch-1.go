//# https://theweeklychallenge.org/blog/perl-weekly-challenge-329/
/*#

Task 1: Counter Integers

Submitted by: [46]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string containing only lower case English letters and
   digits.

   Write a script to replace every non-digit character with a space and
   then return all the distinct integers left.

Example 1

Input: $str = "the1weekly2challenge2"
Output: 1, 2

2 is appeared twice, so we count it one only.

Example 2

Input: $str = "go21od1lu5c7k"
Output: 21, 1, 5, 7

Example 3

Input: $str = "4p3e2r1l"
Output: 4, 3, 2, 1

Task 2: Nice String
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"regexp"
	"strconv"
	"strings"

	"github.com/google/go-cmp/cmp"
)

type input string

func (in input) process() []int {
	var out []int
	seen := make(map[string]struct{})
	for _, v := range strings.Split(strings.Trim(regexp.MustCompile(`\D+`).ReplaceAllString(string(in), " "), " "), " ") {
		if _, ok := seen[v]; !ok {
			seen[v] = struct{}{}
			n, _ := strconv.Atoi(v)
			out = append(out, n)
		}
	}
	return out
}

func main() {
	for _, data := range []struct {
		input  input
		output []int
	}{
		{"the1weekly2challenge2", []int{1, 2}},
		{"go21od1lu5c7k", []int{21, 1, 5, 7}},
		{"4p3e2r1l", []int{4, 3, 2, 1}},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
