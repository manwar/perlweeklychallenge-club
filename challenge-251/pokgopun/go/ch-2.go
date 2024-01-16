//# https://theweeklychallenge.org/blog/perl-weekly-challenge-251/
/*#

Task 2: Lucky Numbers

Submitted by: [53]Mohammad S Anwar
     __________________________________________________________________

   You are given a m x n matrix of distinct numbers.

   Write a script to return the lucky number, if there is one, or -1 if
   not.
A lucky number is an element of the matrix such that it is
the minimum element in its row and maximum in its column.

Example 1

Input: $matrix = [ [ 3,  7,  8],
                   [ 9, 11, 13],
                   [15, 16, 17] ];
Output: 15

15 is the only lucky number since it is the minimum in its row
and the maximum in its column.

Example 2

Input: $matrix = [ [ 1, 10,  4,  2],
                   [ 9,  3,  8,  7],
                   [15, 16, 17, 12] ];
Output: 12

Example 3

Input: $matrix = [ [7 ,8],
                   [1 ,2] ];
Output: 7
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 14th January
   2024.
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

type row []int

func (rw row) minIdx() int {
	l := len(rw)
	switch l {
	case 0:
		return -1
	case 1:
		return 0
	default:
		j := 0
		for i, v := range rw[1:] {
			if rw[j] > v {
				j = i + 1
			}
		}
		return j
	}
}

type matrix []row

func (mt matrix) lucky() int {
	l := len(mt)
	switch l {
	case 1:
		return mt[0][mt[0].minIdx()]
	default:
		for _, rw := range mt {
			i := rw.minIdx()
			mx := mt[0][i]
			for _, v := range mt[1:] {
				mx = max(mx, v[i])
			}
			if mx == rw[i] {
				return mx
			}
		}
	}
	return -1
}

func main() {
	for _, data := range []struct {
		input  matrix
		output int
	}{
		{matrix{row{3, 7, 8}, row{9, 11, 13}, row{15, 16, 17}}, 15},
		{matrix{row{1, 10, 4, 2}, row{9, 3, 8, 7}, row{15, 16, 17, 12}}, 12},
		{matrix{row{7, 8}, row{1, 2}}, 7},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.lucky(), data.output)) // display nothing if ok, otherwise show the difference
	}
}
