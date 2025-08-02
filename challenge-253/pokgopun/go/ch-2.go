//# https://theweeklychallenge.org/blog/perl-weekly-challenge-253/
/*#

Task 2: Weakest Row

Submitted by: [44]Mohammad S Anwar
     __________________________________________________________________

   You are given an m x n binary matrix i.e. only 0 and 1 where 1 always
   appear before 0.

   A row i is weaker than a row j if one of the following is true:
a) The number of 1s in row i is less than the number of 1s in row j.
b) Both rows have the same number of 1 and i < j.

   Write a script to return the order of rows from weakest to strongest.

Example 1

Input: $matrix = [
                   [1, 1, 0, 0, 0],
                   [1, 1, 1, 1, 0],
                   [1, 0, 0, 0, 0],
                   [1, 1, 0, 0, 0],
                   [1, 1, 1, 1, 1]
                 ]
Output: (2, 0, 3, 1, 4)

The number of 1s in each row is:
- Row 0: 2
- Row 1: 4
- Row 2: 1
- Row 3: 2
- Row 4: 5

Example 2

Input: $matrix = [
                   [1, 0, 0, 0],
                   [1, 1, 1, 1],
                   [1, 0, 0, 0],
                   [1, 0, 0, 0]
                 ]
Output: (0, 2, 3, 1)

The number of 1s in each row is:
- Row 0: 1
- Row 1: 4
- Row 2: 1
- Row 3: 1
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 28th January
   2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"cmp"
	"io"
	"os"
	"slices"

	gocmp "github.com/google/go-cmp/cmp"
)

type row []uint8

func (rw row) count() (c uint) {
	for _, v := range rw {
		if v > 0 {
			c++
		}
	}
	return c
}

type matrix []row

func (mt matrix) weakestRow() []uint {
	l := len(mt)
	r := make([]uint, l)
	s := make([]uint, l)
	for i, rw := range mt {
		r[i] = rw.count()
		s[i] = uint(i)
	}
	slices.SortStableFunc(s, func(a, b uint) int {
		return cmp.Compare(r[a], r[b])
	})
	return s
}

func main() {
	for _, data := range []struct {
		input  matrix
		output []uint
	}{
		{
			matrix{
				row{1, 1, 0, 0, 0},
				row{1, 1, 1, 1, 0},
				row{1, 0, 0, 0, 0},
				row{1, 1, 0, 0, 0},
				row{1, 1, 1, 1, 1},
			},
			[]uint{2, 0, 3, 1, 4},
		},
		{
			matrix{
				row{1, 0, 0, 0},
				row{1, 1, 1, 1},
				row{1, 0, 0, 0},
				row{1, 0, 0, 1},
			},
			[]uint{0, 2, 3, 1},
		},
	} {
		io.WriteString(os.Stdout, gocmp.Diff(data.input.weakestRow(), data.output)) //blank if ok, otherwise show the difference
	}
}
