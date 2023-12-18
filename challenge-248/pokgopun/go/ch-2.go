//# https://theweeklychallenge.org/blog/perl-weekly-challenge-248/
/*#

Task 2: Submatrix Sum

Submitted by: [59]Jorg Sommrey
     __________________________________________________________________

   You are given a NxM matrix A of integers.

   Write a script to construct a (N-1)x(M-1) matrix B having elements that
   are the sum over the 2x2 submatrices of A,
b[i,k] = a[i,k] + a[i,k+1] + a[i+1,k] + a[i+1,k+1]

Example 1

Input: $a = [
              [1,  2,  3,  4],
              [5,  6,  7,  8],
              [9, 10, 11, 12]
            ]

Output: $b = [
               [14, 18, 22],
               [30, 34, 38]
             ]

Example 2

Input: $a = [
              [1, 0, 0, 0],
              [0, 1, 0, 0],
              [0, 0, 1, 0],
              [0, 0, 0, 1]
            ]

Output: $b = [
               [2, 1, 0],
               [1, 2, 1],
               [0, 1, 2]
             ]
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 24th December
   2023.
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

type cols []int

type rows []cols

func (rws rows) sub() rows {
	d := len(rws)
	l := len(rws[0])
	s := make(rows, d-1)
	for r := 0; r < d-1; r++ {
		s[r] = make(cols, l-1)
		for c := 0; c < l-1; c++ {
			s[r][c] = rws[r][c] + rws[r][c+1] + rws[r+1][c] + rws[r+1][c+1]
		}
	}
	return s
}

func main() {
	for _, data := range []struct {
		input, output rows
	}{
		{
			rows{
				cols{1, 2, 3, 4},
				cols{5, 6, 7, 8},
				cols{9, 10, 11, 12},
			},
			rows{
				cols{14, 18, 22},
				cols{30, 34, 38},
			},
		},
		{
			rows{
				cols{1, 0, 0, 0},
				cols{0, 1, 0, 0},
				cols{0, 0, 1, 0},
				cols{0, 0, 0, 1},
			},
			rows{
				cols{2, 1, 0},
				cols{1, 2, 1},
				cols{0, 1, 2},
			},
		},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.output, data.input.sub())) // output nothing if ok, otherwise ouput difference
	}
}
