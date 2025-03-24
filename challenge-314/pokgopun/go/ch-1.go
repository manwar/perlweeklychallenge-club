//# https://theweeklychallenge.org/blog/perl-weekly-challenge-314/
/*#

Task 1: Equal Strings

Submitted by: [45]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given three strings.

   You are allowed to remove the rightmost character of a string to make
   all equals.

   Write a script to return the number of operations to make it equal
   otherwise -1.

Example 1

Input: $s1 = "abc", $s2 = "abb", $s3 = "ab"
Output: 2

Operation 1: Delete "c" from the string "abc"
Operation 2: Delete "b" from the string "abb"

Example 2

Input: $s1 = "ayz", $s2 = "cyz", $s3 = "xyz"
Output: -1

Example 3

Input: $s1 = "yza", $s2 = "yzb", $s3 = "yzc"
Output: 3

Task 2: Sort Column
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

type input [3]string

func (in input) process() int {
	s1, s2, s3 := in[0], in[1], in[2]
	if s1 == s2 && s2 == s3 {
		return 0
	}
	sls := [3]int{len(s1), len(s2), len(s3)}
	mn := min(sls[0], sls[1], sls[2])
	sm := 0
	for _, v := range sls {
		sm += v
	}
	if mn == 0 {
		return -1
	}
	if s1[:mn] == s2[:mn] && s2[:mn] == s3[:mn] {
		return sm - 3*mn
	}
	i := 0
	for i < mn {
		if s1[i] != s2[i] || s2[i] != s3[i] {
			break
		}
		i++
	}
	if i == 0 {
		return -1
	}
	return sm - 3*i
}

func main() {
	for _, data := range []struct {
		input  input
		output int
	}{
		{input{"abc", "abb", "ab"}, 2},
		{input{"ayz", "cyz", "xyz"}, -1},
		{input{"yza", "yzb", "yzc"}, 3},
		{input{"abc", "abb", "a"}, 4},
		{input{"", "abb", "a"}, -1},
		{input{"", "", ""}, 0},
		{input{"abcd", "abcd", "abcd"}, 0},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
