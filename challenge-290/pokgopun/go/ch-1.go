//# https://theweeklychallenge.org/blog/perl-weekly-challenge-290/
/*#

Task 1: Double Exist

Submitted by: [45]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints.

   Write a script to find if there exist two indices $i and $j such that:
1) $i != $j
2) 0 <= ($i, $j) < scalar @ints
3) $ints[$i] == 2 * $ints[$j]

Example 1

Input: @ints = (6, 2, 3, 3)
Output: true

For $i = 0, $j = 2
$ints[$i] = 6 => 2 * 3 =>  2 * $ints[$j]

Example 2

Input: @ints = (3, 1, 4, 13)
Output: false

Example 3

Input: @ints = (2, 1, 4, 2)
Output: true

For $i = 2, $j = 3
$ints[$i] = 4 => 2 * 2 =>  2 * $ints[$j]

Task 2: Luhn’s Algorithm
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

type ints []int

func (is ints) de() bool {
	//fmt.Println(is)
	l := len(is)
	for i := 0; i < l-1; i++ {
		for j := i + 1; j < l; j++ {
			a, b := is[i], is[j]
			//fmt.Println(a, b)
			if a == b {
				continue
			}
			if max(a, b) == min(a, b)*2 {
				return true
			}
		}
	}
	return false
}

func main() {
	for _, data := range []struct {
		input  ints
		output bool
	}{
		{ints{6, 2, 3, 3}, true},
		{ints{3, 1, 4, 13}, false},
		{ints{2, 1, 4, 2}, true},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.de(), data.output)) // blank if ok, otherwise show the differences
	}
}
