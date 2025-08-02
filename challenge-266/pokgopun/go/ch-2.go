//# https://theweeklychallenge.org/blog/perl-weekly-challenge-266/
/*#

Task 2: X Matrix

Submitted by: [42]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a square matrix, $matrix.

   Write a script to find if the given matrix is X Matrix.

     A square matrix is an X Matrix if all the elements on the main
     diagonal and antidiagonal are non-zero and everything else are zero.

Example 1

Input: $matrix = [ [1, 0, 0, 2],
                   [0, 3, 4, 0],
                   [0, 5, 6, 0],
                   [7, 0, 0, 1],
                 ]
Output: true

Example 2

Input: $matrix = [ [1, 2, 3],
                   [4, 5, 6],
                   [7, 8, 9],
                 ]
Output: false

Example 3

Input: $matrix = [ [1, 0, 2],
                   [0, 3, 0],
                   [4, 0, 5],
                 ]
Output: true
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 28th April
   2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"errors"
	"io"
	"log"
	"os"

	"github.com/google/go-cmp/cmp"
)

type row []int

type matrix []row

func (mtx matrix) isSquare() bool {
	l := len(mtx)
	i := l
	for i > 0 {
		i--
		if len(mtx[i]) != l {
			return false
		}
	}
	return true
}

type squareMatrix struct {
	l int
	m matrix
}

func newSquareMatrix(mtx matrix) (squareMatrix, error) {
	if mtx.isSquare() {
		return squareMatrix{len(mtx), mtx}, nil
	}
	return squareMatrix{}, errors.New("not square")
}

func (sm squareMatrix) onX(r, c int) bool {
	if r == c || r == sm.l-c-1 || c == sm.l-r-1 {
		return true
	}
	return false
}

func (sm squareMatrix) isX() bool {
	var v int
	for r := 0; r < sm.l; r++ {
		for c := 0; c < sm.l; c++ {
			v = sm.m[r][c]
			if sm.onX(r, c) {
				if v == 0 {
					return false
				}
			} else {
				if v != 0 {
					return false
				}
			}
		}
	}
	return true
}

func main() {
	for _, data := range []struct {
		input  matrix
		output bool
	}{
		{matrix{
			row{1, 0, 0, 2},
			row{0, 3, 4, 0},
			row{0, 5, 6, 0},
			row{7, 0, 0, 1},
		}, true},
		{matrix{
			row{1, 2, 3},
			row{4, 5, 6},
			row{7, 8, 9},
		}, false},
		{matrix{
			row{1, 0, 2},
			row{0, 3, 0},
			row{4, 0, 5},
		}, true},
	} {
		sm, err := newSquareMatrix(data.input)
		if err != nil {
			log.Fatal(err)
		}
		io.WriteString(os.Stdout, cmp.Diff(sm.isX(), data.output)) // blank if ok, otherwise show the difference
	}
}
