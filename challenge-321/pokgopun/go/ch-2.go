//# https://theweeklychallenge.org/blog/perl-weekly-challenge-321/
/*#

Task 2: Backspace Compare

Submitted by: [45]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given two strings containing zero or more #.

   Write a script to return true if the two given strings are same by
   treating # as backspace.

Example 1

Input: $str1 = "ab#c"
       $str2 = "ad#c"
Output: true

For first string,  we remove "b" as it is followed by "#".
For second string, we remove "d" as it is followed by "#".
In the end both strings became the same.

Example 2

Input: $str1 = "ab##"
       $str2 = "a#b#"
Output: true

Example 3

Input: $str1 = "a#b"
       $str2 = "c"
Output: false
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 18th May 2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"slices"

	"github.com/google/go-cmp/cmp"
)

type input struct {
	str1, str2 string
}

func (in input) process() bool {
	//fmt.Printf("%v, '%s', '%s'\n", in, ab(in.str1), ab(in.str2))
	return ab(in.str1) == ab(in.str2)
}

func ab(str string) string {
	l := len(str)
	bs := []byte(str)
	i := 0
	for i < l {
		if bs[i] == byte('#') {
			if i > 0 {
				slices.Delete(bs, i-1, i+1)
				l -= 2
				i--
			} else {
				slices.Delete(bs, i, i+1)
				l--
			}
		} else {
			i++
		}
	}
	return string(bs)
}

func main() {
	for _, data := range []struct {
		input  input
		output bool
	}{
		{input{"ab#c", "ad#c"}, true},
		{input{"ab##", "a#b#"}, true},
		{input{"a#b", "c"}, false},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
