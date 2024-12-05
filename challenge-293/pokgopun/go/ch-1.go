//# https://theweeklychallenge.org/blog/perl-weekly-challenge-293/
/*#

Task 1: Similar Dominos

Submitted by: [40]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a list of dominos, @dominos.

   Write a script to return the number of dominoes that are similar to any
   other domino.

     $dominos[i] = [a, b] and $dominos[j] = [c, d] are same if either (a
     = c and b = d) or (a = d and b = c).

Example 1

Input: @dominos = ([1, 3], [3, 1], [2, 4], [6, 8])
Output: 2

Similar Dominos: $dominos[0], $dominos[1]

Example 2

Input: @dominos = ([1, 2], [2, 1], [1, 1], [1, 2], [2, 2])
Output: 3

Similar Dominos: $dominos[0], $dominos[1], $dominos[3]

Task 2: Boomerang
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

type domino [2]int

type dominos []domino

func (ds dominos) countSimilar() int {
	m := make(map[domino]int)
	for _, d := range ds {
		if d[0] > d[1] {
			d[0], d[1] = d[1], d[0]
		}
		m[d]++
	}
	c := 0
	for _, v := range m {
		if v > 1 {
			c += v
		}
	}
	return c
}

func main() {
	for _, data := range []struct {
		input  dominos
		output int
	}{
		{dominos{domino{1, 3}, domino{3, 1}, domino{2, 4}, domino{6, 8}}, 2},
		{dominos{domino{1, 2}, domino{2, 1}, domino{1, 1}, domino{1, 2}, domino{2, 2}}, 3},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.countSimilar(), data.output)) // blank if ok, otherwise show the difference
	}
}
