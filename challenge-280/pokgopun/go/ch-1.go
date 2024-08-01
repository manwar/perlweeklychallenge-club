//# https://theweeklychallenge.org/blog/perl-weekly-challenge-280/
/*#

Task 1: Twice Appearance

Submitted by: [53]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string, $str, containing lowercase English letters
   only.

   Write a script to print the first letter that appears twice.

Example 1

Input: $str = "acbddbca"
Output: "d"

Example 2

Input: $str = "abccd"
Output: "c"

Example 3

Input: $str = "abcdabbb"
Output: "a"

Task 2: Count Asterisks
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

func twcApr(str string) rune {
	m := make(map[rune]int)
	var (
		c  rune
		mn int
	)
	for i, v := range str {
		//fmt.Println(string(v), v)
		if m[v] == 0 {
			m[v] = -i - 1
		} else if m[v] < 0 {
			m[v] = i + 1
		}
		if m[v] > 0 {
			if mn == 0 || mn > m[v] {
				mn = m[v]
				c = v
			}
		}
	}
	//fmt.Println(m)
	return c
}

func main() {
	for _, data := range []struct {
		input  string
		output rune
	}{
		{"acbddbca", 'd'},
		{"abccd", 'c'},
		{"abcdabbb", 'a'},
	} {
		io.WriteString(os.Stdout, cmp.Diff(twcApr(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
