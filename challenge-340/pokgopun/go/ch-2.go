//# https://theweeklychallenge.org/blog/perl-weekly-challenge-340/
/*#

Task 2: Ascending Numbers

Submitted by: [49]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string, $str, is a list of tokens separated by a single
   space. Every token is either a positive number consisting of digits 0-9
   with no leading zeros, or a word consisting of lowercase English
   letters.

   Write a script to check if all the numbers in the given string are
   strictly increasing from left to right.

Example 1

Input: $str = "The cat has 3 kittens 7 toys 10 beds"
Output: true

Numbers 3, 7, 10 - strictly increasing.

Example 2

Input: $str = 'Alice bought 5 apples 2 oranges 9 bananas'
Output: false

Example 3

Input: $str = 'I ran 1 mile 2 days 3 weeks 4 months'
Output: true

Example 4

Input: $str = 'Bob has 10 cars 10 bikes'
Output: false

Example 5

Input: $str = 'Zero is 0 one is 1 two is 2'
Output: true
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 28th September
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"regexp"
	"slices"
	"strconv"

	"github.com/google/go-cmp/cmp"
)

func an(str string) bool {
	re := regexp.MustCompile(`\d+`)
	var s []int
	for _, v := range re.FindAllStringIndex(str, -1) {
		n, _ := strconv.Atoi(str[v[0]:v[1]])
		s = append(s, n)
	}
	l := len(s)
	return slices.IsSorted(s) && len(slices.Compact(s)) == l
}

func main() {
	for _, data := range []struct {
		input  string
		output bool
	}{
		{"The cat has 3 kittens 7 toys 10 beds", true},
		{"Alice bought 5 apples 2 oranges 9 bananas", false},
		{"I ran 1 mile 2 days 3 weeks 4 months", true},
		{"Bob has 10 cars 10 bikes", false},
		{"Zero is 0 one is 1 two is 2", true},
	} {
		//fmt.Println(data.input)
		io.WriteString(os.Stdout, cmp.Diff(an(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
