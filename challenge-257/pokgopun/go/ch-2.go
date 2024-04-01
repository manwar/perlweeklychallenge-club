//# https://theweeklychallenge.org/blog/perl-weekly-challenge-257/
/*#

Task 2: Reduced Row Echelon

Submitted by: [45]Ali Moradi
     __________________________________________________________________

   Given a matrix M, check whether the matrix is in reduced row echelon
   form.

   A matrix must have the following properties to be in reduced row
   echelon form:
1. If a row does not consist entirely of zeros, then the first
   nonzero number in the row is a 1. We call this the leading 1.
2. If there are any rows that consist entirely of zeros, then
   they are grouped together at the bottom of the matrix.
3. In any two successive rows that do not consist entirely of zeros,
   the leading 1 in the lower row occurs farther to the right than
   the leading 1 in the higher row.
4. Each column that contains a leading 1 has zeros everywhere else
   in that column.

   For example:
[
   [1,0,0,1],
   [0,1,0,2],
   [0,0,1,3]
]

   The above matrix is in reduced row echelon form since the first nonzero
   number in each row is a 1, leading 1s in each successive row are
   farther to the right, and above and below each leading 1 there are only
   zeros.

   For more information check out this wikipedia [46]article.

Example 1

    Input: $M = [
                  [1, 1, 0],
                  [0, 1, 0],
                  [0, 0, 0]
                ]
    Output: 0

Example 2

    Input: $M = [
                  [0, 1,-2, 0, 1],
                  [0, 0, 0, 1, 3],
                  [0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0]
                ]
    Output: 1

Example 3

    Input: $M = [
                  [1, 0, 0, 4],
                  [0, 1, 0, 7],
                  [0, 0, 1,-1]
                ]
    Output: 1

Example 4

    Input: $M = [
                  [0, 1,-2, 0, 1],
                  [0, 0, 0, 0, 0],
                  [0, 0, 0, 1, 3],
                  [0, 0, 0, 0, 0]
                ]
    Output: 0

Example 5

    Input: $M = [
                  [0, 1, 0],
                  [1, 0, 0],
                  [0, 0, 0]
                ]
    Output: 0

Example 6

    Input: $M = [
                  [4, 0, 0, 0],
                  [0, 1, 0, 7],
                  [0, 0, 1,-1]
                ]
    Output: 0
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 25th February
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

func (rw row) isAllZero() bool {
	for _, v := range rw {
		if v != 0 {
			return false
		}
	}
	return true
}

func (rw row) l1Pos() int {
	for i, v := range rw {
		if v == 1 {
			return i
		}
	}
	return -1
}

type matrix []row

func (mt matrix) noButtomZeroes() matrix {
	s := mt
	l := len(mt)
	lz := l
	for l > 0 {
		l--
		if mt[l].isAllZero() {
			s = mt[:l]
			lz--
		}
		if l != lz {
			break
		}
	}
	return s
}

func (mt matrix) isSingleNonZeroColumn(col int) bool {
	c := 0
	for _, v := range mt.noButtomZeroes() {
		if v[col] != 0 {
			c++
		}
		if c > 1 {
			return false
		}
	}
	return c == 1
}

func (mt matrix) isReducedRowEchelon() bool {
	l1p := -1
	for _, v := range mt.noButtomZeroes() {
		l1 := v.l1Pos()
		if l1 < 0 || l1 < l1p || mt.isSingleNonZeroColumn(l1) == false {
			return false
		}
		l1p = l1
	}
	return true
}

func main() {
	for _, data := range []struct {
		input  matrix
		output bool
	}{
		{
			matrix{
				row{1, 1, 0},
				row{0, 1, 0},
				row{0, 0, 0},
			}, false,
		},
		{
			matrix{
				row{0, 1, -2, 0, 1},
				row{0, 0, 0, 1, 3},
				row{0, 0, 0, 0, 0},
				row{0, 0, 0, 0, 0},
			}, true,
		},
		{
			matrix{
				row{1, 0, 0, 4},
				row{0, 1, 0, 7},
				row{0, 0, 1, -1},
			}, true,
		},
		{
			matrix{
				row{0, 1, -2, 0, 1},
				row{0, 0, 0, 0, 0},
				row{0, 0, 0, 1, 3},
				row{0, 0, 0, 0, 0},
			}, false,
		},
		{
			matrix{
				row{0, 1, 0},
				row{1, 0, 0},
				row{0, 0, 0},
			}, false,
		},
		{
			matrix{
				row{4, 0, 0, 0},
				row{0, 1, 0, 7},
				row{0, 0, 1, -1},
			}, false,
		},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.isReducedRowEchelon(), data.output)) // blank if ok, otherwise show the difference
	}
}
