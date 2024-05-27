//# https://theweeklychallenge.org/blog/perl-weekly-challenge-270/
/*#

Task 1: Special Positions

Submitted by: [43]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a m x n binary matrix.

   Write a script to return the number of special positions in the given
   binary matrix.

     A position (i, j) is called special if $matrix[i][j] == 1 and all
     other elements in the row i and column j are 0.

Example 1

Input: $matrix = [ [1, 0, 0],
                   [0, 0, 1],
                   [1, 0, 0],
                 ]
Output: 1

There is only special position (1, 2) as $matrix[1][2] == 1
and all other elements in row 1 and column 2 are 0.

Example 2

Input: $matrix = [ [1, 0, 0],
                   [0, 1, 0],
                   [0, 0, 1],
                 ]
Output: 3

Special positions are (0,0), (1, 1) and (2,2).

Task 2: Distribute Elements
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

type row []int

func (rw row) hasOneAndZeroes() bool {
	var cnt1, cntNot01 int
	for _, v := range rw {
		if v == 1 {
			cnt1++
			if cnt1 > 1 {
				return false
			}
		} else if v != 0 {
			cntNot01++
			if cntNot01 > 0 {
				return false
			}
		}
	}
	if cnt1 == 0 {
		return false
	}
	return true
}

type matrix []row

func (mtx matrix) cross(r, c int) [2]row {
	h := mtx[r]
	l := len(mtx)
	v := make(row, l)
	for i := range l {
		v[i] = mtx[i][c]
	}
	return [2]row{h, v}
}

func (mtx matrix) isSP(r, c int) bool {
	if mtx[r][c] != 1 {
		return false
	}
	for _, v := range mtx.cross(r, c) {
		if !v.hasOneAndZeroes() {
			return false
		}
	}
	return true
}

func (mtx matrix) countSP() int {
	count := 0
	m := len(mtx)
	n := mtx[0]
	for r := range m {
		for c := range n {
			if mtx.isSP(r, c) {
				count++
			}
		}
	}
	return count
}

func main() {
	for _, data := range []struct {
		input  matrix
		output int
	}{
		{
			matrix{
				row{1, 0, 0},
				row{0, 0, 1},
				row{1, 0, 0},
			}, 1,
		},
		{
			matrix{
				row{1, 0, 0},
				row{0, 1, 0},
				row{0, 0, 1},
			}, 3,
		},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.countSP(), data.output)) // blank if ok, otherwise show the difference
	}
}
