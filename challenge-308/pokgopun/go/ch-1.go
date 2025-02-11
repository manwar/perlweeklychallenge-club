//# https://theweeklychallenge.org/blog/perl-weekly-challenge-308/
/*#

Task 1: Count Common

Submitted by: [46]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given two array of strings, @str1 and @str2.

   Write a script to return the count of common strings in both arrays.

Example 1

Input: @str1 = ("perl", "weekly", "challenge")
       @str2 = ("raku", "weekly", "challenge")
Output: 2

Example 2

Input: @str1 = ("perl", "raku", "python")
       @str2 = ("python", "java")
Output: 1

Example 3

Input: @str1 = ("guest", "contribution")
       @str2 = ("fun", "weekly", "challenge")
Output: 0

Task 2: Decode XOR
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

type strs []string

type input struct {
	str1, str2 strs
}

func (in input) process() int {
	m := make(map[string]bool)
	for _, v := range in.str1 {
		m[v] = true
	}
	c := 0
	for _, v := range in.str2 {
		if m[v] {
			c++
			m[v] = false
		}
	}
	/*
		for k, v := range m {
			if v {
				delete(m, k)
			}
		}
		fmt.Println(m)
	*/
	return c
}

func main() {
	for _, data := range []struct {
		input  input
		output int
	}{
		{input{strs{"perl", "weekly", "challenge"}, strs{"raku", "weekly", "challenge"}}, 2},
		{input{strs{"perl", "raku", "python"}, strs{"python", "java"}}, 1},
		{input{strs{"guest", "contribution"}, strs{"fun", "weekly", "challenge"}}, 0},
		{input{strs{"perl", "raku", "perl"}, strs{"perl", "perl"}}, 1},
		{input{strs{"challenge", "challenge", "challenge"}, strs{"challenge", "weekly", "challenge"}}, 1},
		{input{strs{"challenge", "go", "challenge"}, strs{"go", "challenge", "go"}}, 2},
	} {
		//fmt.Println(data.input)
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
