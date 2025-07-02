//# https://theweeklychallenge.org/blog/perl-weekly-challenge-328/
/*#

Task 2: Good String

Submitted by: [43]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string made up of lower and upper case English letters
   only.

   Write a script to return the good string of the given string. A string
   is called good string if it doesn’t have two adjacent same characters,
   one in upper case and other is lower case.

Example 1

Input: $str = "WeEeekly"
Output: "Weekly"

We can remove either, "eE" or "Ee" to make it good.

Example 2

Input: $str = "abBAdD"
Output: ""

We remove "bB" first: "aAdD"
Then we remove "aA": "dD"
Finally remove "dD".

Example 3

Input: $str = "abc"
Output: "abc"
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 6th July 2025.
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

type input string

func (in input) process() string {
	//fmt.Println("=>", in)
	rs := []rune(in)
	l := len(rs)
	for l > 1 {
		i := l
		for {
			i--
			if max(rs[i], rs[i-1])-min(rs[i], rs[i-1]) == 'a'-'A' {
				//fmt.Println("removing", string([]rune{rs[i], rs[i-1]}))
				copy(rs[i-1:], rs[i+1:])
				l -= 2
				rs = rs[:l]
				//fmt.Println("=>", string(rs))
				break
			}
			if i > 1 {
				continue
			}
			//fmt.Println("i=", i, "l=", l)
			return string(rs)
		}
	}
	return string(rs)
}

func main() {
	for _, data := range []struct {
		input  input
		output string
	}{
		{"WeEeekly", "Weekly"},
		{"abBAdD", ""},
		{"abc", "abc"},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
