//# https://theweeklychallenge.org/blog/perl-weekly-challenge-298/
/*#

Task 1: Maximal Square

Submitted by: [45]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an m x n binary matrix with 0 and 1 only.

   Write a script to find the largest square containing only 1's and
   return it’s area.

Example 1

Input: @matrix = ([1, 0, 1, 0, 0],
                  [1, 0, 1, 1, 1],
                  [1, 1, 1, 1, 1],
                  [1, 0, 0, 1, 0])
Output: 4

Two maximal square found with same size marked as 'x':

[1, 0, 1, 0, 0]
[1, 0, x, x, 1]
[1, 1, x, x, 1]
[1, 0, 0, 1, 0]

[1, 0, 1, 0, 0]
[1, 0, 1, x, x]
[1, 1, 1, x, x]
[1, 0, 0, 1, 0]

Example 2

Input: @matrix = ([0, 1],
                  [1, 0])
Output: 1

Two maximal square found with same size marked as 'x':

[0, x]
[1, 0]


[0, 1]
[x, 0]

Example 3

Input: @matrix = ([0])
Output: 0

Task 2: Right Interval
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"iter"
	"os"

	"github.com/google/go-cmp/cmp"
)

type row []int

type rows []row

type matrix struct {
	rws  rows
	h, w int
}

func newMatrix(rws rows) matrix {
	return matrix{rws, len(rws), len(rws[0])}
}

type point struct {
	r, c int
}

type square struct {
	start, end point
}

func (mtx matrix) square(l int) iter.Seq[square] {
	return func(yield func(square) bool) {
		var done bool
		for r := range mtx.h - l + 1 {
			for c := range mtx.w - l + 1 {
				start := point{r, c}
				end := point{r + l - 1, c + l - 1}
				if !yield(square{start, end}) {
					done = true
					break
				}
			}
			if done {
				break
			}
		}
	}
}

func (mtx matrix) value(p point) int {
	return mtx.rws[p.r][p.c]
}

func (mtx matrix) maximalSquare() int {
	l := min(mtx.h, mtx.w)
	for l > 0 {
		for sqr := range mtx.square(l) {
			if mtx.isFilled(sqr) {
				return l * l
			}
		}
		l--
	}
	return 0
}

func (mtx matrix) isFilled(sqr square) bool {
	for r := sqr.start.r; r <= sqr.end.r; r++ {
		for c := sqr.start.c; c <= sqr.end.c; c++ {
			if mtx.value(point{r, c}) == 0 {
				return false
			}
		}
	}
	return true
}

func main() {
	for _, data := range []struct {
		input  rows
		output int
	}{
		{rows{
			row{1, 0, 1, 0, 0},
			row{1, 0, 1, 1, 1},
			row{1, 1, 1, 1, 1},
			row{1, 0, 0, 1, 0},
		}, 4},
		{rows{
			row{0, 1},
			row{1, 0},
		}, 1},
		{rows{
			row{0},
		}, 0},
	} {
		io.WriteString(os.Stdout, cmp.Diff(newMatrix(data.input).maximalSquare(), data.output)) // blank if ok, otherwise show the difference
	}
}
