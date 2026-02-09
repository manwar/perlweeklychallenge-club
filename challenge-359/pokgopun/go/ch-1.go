//# https://theweeklychallenge.org/blog/perl-weekly-challenge-359/
/*#

Task 1: Digital Root

Submitted by: [45]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a positive integer, $int.

   Write a function that calculates the additive persistence of a positive
   integer and also return the digital root.

     Digital root is the recursive sum of all digits in a number until a
     single digit is obtained.

     Additive persistence is the number of times you need to sum the
     digits to reach a single digit.

Example 1

Input: $int = 38
Output: Persistence  = 2
        Digital Root = 2

38 => 3 + 8 => 11
11 => 1 + 1 => 2

Example 2

Input: $int = 7
Output: Persistence  = 0
        Digital Root = 7

Example 3

Input: $int = 999
Output: Persistence  = 2
        Digital Root = 9

999 => 9 + 9 + 9 => 27
27  => 2 + 7 => 9

Example 4

Input: $int = 1999999999
Output: Persistence  = 3
        Digital Root = 1

1999999999 => 1 + 9 + 9 + 9 + 9 + 9 + 9 + 9 + 9 + 9 => 82
82 => 8 + 2 => 10
10 => 1 + 0 => 1

Example 5

Input: $int = 101010
Output: Persistence  = 1
        Digital Root = 3

101010 => 1 + 0 + 1 + 0 + 1 + 0 => 3

Task 2: String Reduction
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"strconv"

	"github.com/google/go-cmp/cmp"
)

type output struct {
	P, DR int
}

type input int

func (in input) process() output {
	n := int(in)
	var c, d int
	for n > 9 {
		c++
		d, n = n, 0
		for _, v := range strconv.Itoa(d) {
			n += int(v - '0')
		}
	}
	return output{c, n}
}

func main() {
	for _, data := range []struct {
		input input
		p, dr int
	}{
		{38, 2, 2},
		{7, 0, 7},
		{999, 2, 9},
		{1999999999, 3, 1},
		{101010, 1, 3},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), output{data.p, data.dr})) // blank if ok, otherwise show the difference
	}
}
