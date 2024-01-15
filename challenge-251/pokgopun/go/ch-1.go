//# https://theweeklychallenge.org/blog/perl-weekly-challenge-251/
/*#

Task 1: Concatenation Value

Submitted by: [52]Mohammad S Anwar
     __________________________________________________________________

   You are given an array of integers, @ints.

   Write a script to find the concatenation value of the given array.

   The concatenation of two numbers is the number formed by concatenating
   their numerals.
For example, the concatenation of 10, 21 is 1021.
The concatenation value of @ints is initially equal to 0.
Perform this operation until @ints becomes empty:

If there exists more than one number in @ints, pick the first element
and last element in @ints respectively and add the value of their
concatenation to the concatenation value of @ints, then delete the
first and last element from @ints.

If one element exists, add its value to the concatenation value of
@ints, then delete it.

Example 1

Input: @ints = (6, 12, 25, 1)
Output: 1286

1st operation: concatenation of 6 and 1 is 61
2nd operation: concaternation of 12 and 25 is 1225

Concatenation Value => 61 + 1225 => 1286

Example 2

Input: @ints = (10, 7, 31, 5, 2, 2)
Output: 489

1st operation: concatenation of 10 and 2 is 102
2nd operation: concatenation of 7 and 2 is 72
3rd operation: concatenation of 31 and 5 is 315

Concatenation Value => 102 + 72 + 315 => 489

Example 3

Input: @ints = (1, 2, 10)
Output: 112

1st operation: concatenation of 1 and 10 is 110
2nd operation: only element left is 2

Concatenation Value => 110 + 2 => 112

Task 2: Lucky Numbers
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

type ints []int

func (is ints) concat() int {
	l := len(is)
	switch l {
	case 0:
		return 0
	case 1:
		return is[0]
	default:
		c := is[0]
		for i := 1; i < l; i++ {
			lim := is[i]
			for lim > 0 {
				lim /= 10
				c *= 10
			}
			c += is[i]
		}
		return c
	}
}

func (is ints) concatenation() int {
	l := len(is)
	lim := l / 2
	c := 0
	for i := 0; i < lim; i++ {
		//fmt.Println(ints{is[i], is[l-1-i]}.concat())
		c += ints{is[i], is[l-1-i]}.concat()
	}
	if l%2 == 1 {
		c += is[lim]
	}
	return c
}

func main() {
	for _, data := range []struct {
		input  ints
		output int
	}{
		{ints{6, 12, 25, 1}, 1286},
		{ints{10, 7, 31, 5, 2, 2}, 489},
		{ints{1, 2, 10}, 112},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.concatenation(), data.output)) // display nothing if ok, otherwise show the difference
	}
}
