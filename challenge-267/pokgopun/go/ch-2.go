//# https://theweeklychallenge.org/blog/perl-weekly-challenge-267/
/*#

Task 2: Line Counts

Submitted by: [43]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string, $str, and a 26-items array @widths containing
   the width of each character from a to z.

   Write a script to find out the number of lines and the width of the
   last line needed to display the given string, assuming you can only fit
   100 width units on a line.

Example 1

Input: $str = "abcdefghijklmnopqrstuvwxyz"
       @widths = (10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10
,10,10,10,10,10)
Output: (3, 60)

Line 1: abcdefghij (100 pixels)
Line 2: klmnopqrst (100 pixels)
Line 3: uvwxyz (60 pixels)

Example 2

Input: $str = "bbbcccdddaaa"
       @widths = (4,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,
10,10,10,10,10)
Output: (2, 4)

Line 1: bbbcccdddaa (98 pixels)
Line 2: a (4 pixels)
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 5th May 2024.
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

const lim int = 100

type Answer struct {
	Lc, L int
}

type text string

func (txt text) lc(widths []int) Answer {
	var l, lc, w int
	lc = 1
	var b byte
	for _, b = range []byte(txt) {
		w = widths[b-97]
		l += w
		if l > lim {
			lc++
			l = w
		}
	}
	return Answer{lc, l}
}

func main() {
	for _, data := range []struct {
		str    text
		widths []int
		ans    Answer
	}{
		{"abcdefghijklmnopqrstuvwxyz", []int{10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10}, Answer{3, 60}},
		{"bbbcccdddaaa", []int{4, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10}, Answer{2, 4}},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.str.lc(data.widths), data.ans)) // blank if ok,, otherwise show the difference
	}
}
