//# https://theweeklychallenge.org/blog/perl-weekly-challenge-279/
/*#

Task 2: Split String

Submitted by: [46]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string, $str.

   Write a script to split the given string into two containing exactly
   same number of vowels and return true if you can otherwise false.

Example 1

Input: $str = "perl"
Ouput: false

Example 2

Input: $str = "book"
Ouput: true

Two possible strings "bo" and "ok" containing exactly one vowel each.

Example 3

Input: $str = "good morning"
Ouput: true

Two possible strings "good " and "morning" containing two vowels each or "good m
" and "orning" containing two vowels each.
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 28th July 2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

type text string

func (tx text) vwlIdx() []int {
	var r []int
	for i, v := range tx {
		switch v {
		case 'a', 'e', 'i', 'o', 'u':
			r = append(r, i)
		}
	}
	return r
}

func splitString0(str text) bool {
	l := len(str.vwlIdx())
	if l > 0 {
		return l%2 == 0
	}
	return false
}

type splitted struct {
	First, Second text
	Ok            bool
}

func splitString1(str text) splitted {
	idx := str.vwlIdx()
	l := len(idx)
	h := l / 2
	b := l%2 == 0
	if b {
		h -= 1
	}
	var i int
	if l > 1 {
		i = idx[h+1]
	} else {
		i = idx[h] + 1
	}
	return splitted{str[:i], str[i:], b}
}

func main() {
	for _, data := range []struct {
		str    text
		output splitted
	}{
		{"perl", splitted{"pe", "rl", false}},
		{"book", splitted{"bo", "ok", true}},
		{"good morning", splitted{"good m", "orning", true}},
	} {
		io.WriteString(os.Stdout, cmp.Diff(splitString0(data.str), data.output.Ok)) // blank if ok, otherwise show the difference
		io.WriteString(os.Stdout, cmp.Diff(splitString1(data.str), data.output))    // blank if ok, otherwise show the difference
	}
}
