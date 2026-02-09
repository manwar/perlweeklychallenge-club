//# https://theweeklychallenge.org/blog/perl-weekly-challenge-360/
/*#

Task 1: Text Justifier

Submitted by: [46]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string and a width.

   Write a script to return the string that centers the text within that
   width using asterisks * as padding.

Example 1

Input: $str = "Hi", $width = 5
Output: "*Hi**"

Text length = 2, Width = 5
Need 3 padding characters total
Left padding: 1 star, Right padding: 2 stars

Example 2

Input: $str = "Code", $width = 10
Output: "***Code***"

Text length = 4, Width = 10
Need 6 padding characters total
Left padding: 3 stars, Right padding: 3 stars

Example 3

Input: $str = "Hello", $width = 9
Output: "**Hello**"

Text length = 5, Width = 9
Need 4 padding characters total
Left padding: 2 stars, Right padding: 2 stars

Example 4

Input: $str = "Perl", $width = 4
Output: "Perl"

No padding needed

Example 5

Input: $str = "A", $width = 7
Output: "***A***"

Text length = 1, Width = 7
Need 6 padding characters total
Left padding: 3 stars, Right padding: 3 stars

Example 6

Input: $str = "", $width = 5
Output: "*****"

Text length = 0, Width = 5
Entire output is padding

Task 2: Word Sorter
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

func textJustifier(str string, width int) string {
	bs := make([]byte, width)
	j := (width - len(str)) / 2
	l := copy(bs[j:], []byte(str))
	i := j + l
	for width > i {
		width--
		bs[width] = '*'
	}
	for j > 0 {
		j--
		bs[j] = '*'
	}
	return string(bs)
}

func main() {
	for _, data := range []struct {
		str    string
		width  int
		output string
	}{
		{"Hi", 5, "*Hi**"},
		{"Code", 10, "***Code***"},
		{"Hello", 9, "**Hello**"},
		{"Perl", 4, "Perl"},
		{"A", 7, "***A***"},
		{"", 5, "*****"},
	} {
		io.WriteString(os.Stdout, cmp.Diff(textJustifier(data.str, data.width), data.output)) // blank if ok, otherwise show the difference
	}
}
