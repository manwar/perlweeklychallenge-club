//# https://theweeklychallenge.org/blog/perl-weekly-challenge-271/
/*#

Task 1: Maximum Ones

Submitted by: [42]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a m x n binary matrix.

   Write a script to return the row number containing maximum ones, in
   case of more than one rows then return smallest row number.

Example 1

Input: $matrix = [ [0, 1],
                   [1, 0],
                 ]
Output: 1

Row 1 and Row 2 have the same number of ones, so return row 1.

Example 2

Input: $matrix = [ [0, 0, 0],
                   [1, 0, 1],
                 ]
Output: 2

Row 2 has the maximum ones, so return row 2.

Example 3

Input: $matrix = [ [0, 0],
                   [1, 1],
                   [0, 0],
                 ]
Output: 2

Row 2 have the maximum ones, so return row 2.

Task 2: Sort by 1 bits
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

type row []int

func (rw row) countOne() int {
	c := 0
	l := len(rw)
	for i := 0; i < l; i++ {
		if rw[i] == 1 {
			c++
		}
	}
	return c
}

type matrix []row

func (mtx matrix) maxOneRow() int {
	idx := 0
	mx := len(mtx[idx])
	cnt := mtx[idx].countOne()
	if cnt == mx {
		return idx + 1
	}
	cntMx, cntMxIdx := cnt, idx
	l := len(mtx)
	for idx = 1; idx < l; idx++ {
		cnt = mtx[idx].countOne()
		if cnt == mx {
			return idx + 1
		}
		if cnt > cntMx {
			cntMx = cnt
			cntMxIdx = idx
		}
	}
	return cntMxIdx + 1
}

func main() {
	for _, data := range []struct {
		input  matrix
		output int
	}{
		{
			matrix{
				row{0, 1},
				row{1, 0},
			},
			1,
		},
		{
			matrix{
				row{0, 0, 0},
				row{1, 0, 1},
			},
			2,
		},
		{
			matrix{
				row{0, 0},
				row{1, 1},
				row{0, 0},
			},
			2,
		},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.maxOneRow(), data.output)) // blank if ok, otherwise show the difference
	}
}
