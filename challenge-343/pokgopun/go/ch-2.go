//# https://theweeklychallenge.org/blog/perl-weekly-challenge-343/
/*#

Task 2: Champion Team

Submitted by: [40]Mohammad Sajid Anwar
     __________________________________________________________________

   You have n teams in a tournament. A matrix grid tells you which team is
   stronger between any two teams:
If grid[i][j] == 1, then team i is stronger than team j
If grid[i][j] == 0, then team j is stronger than team i

   Find the champion team - the one with most wins, or if there is no
   single such team, the strongest of the teams with most wins. (You may
   assume that there is a definite answer.)

Example 1

Input: @grid = (
                 [0, 1, 1],
                 [0, 0, 1],
                 [0, 0, 0],
               )
Output: Team 0

[0, 1, 1] => Team 0 beats Team 1 and Team 2
[0, 0, 1] => Team 1 beats Team 2
[0, 0, 0] => Team 2 loses to all

Example 2

Input: @grid = (
                 [0, 1, 0, 0],
                 [0, 0, 0, 0],
                 [1, 1, 0, 0],
                 [1, 1, 1, 0],
               )
Output: Team 3

[0, 1, 0, 0] => Team 0 beats only Team 1
[0, 0, 0, 0] => Team 1 loses to all
[1, 1, 0, 0] => Team 2 beats Team 0 and Team 1
[1, 1, 1, 0] => Team 3 beats everyone

Example 3

Input: @grid = (
                 [0, 1, 0, 1],
                 [0, 0, 1, 1],
                 [1, 0, 0, 0],
                 [0, 0, 1, 0],
               )
Output: Team 0

[0, 1, 0, 1] => Team 0 beats teams 1 and 3
[0, 0, 1, 1] => Team 1 beats teams 2 and 3
[1, 0, 0, 0] => Team 2 beats team 0
[0, 0, 1, 0] => Team 3 beats team 2

Of the teams with 2 wins, Team 0 beats team 1.

Example 4

Input: @grid = (
                 [0, 1, 1],
                 [0, 0, 0],
                 [0, 1, 0],
               )
Output: Team 0

[0, 1, 1] => Team 0 beats Team 1 and Team 2
[0, 0, 0] => Team 1 loses to Team 2
[0, 1, 0] => Team 2 beats Team 1 but loses to Team 0

Example 5

Input: @grid = (
                 [0, 0, 0, 0, 0],
                 [1, 0, 0, 0, 0],
                 [1, 1, 0, 1, 1],
                 [1, 1, 0, 0, 0],
                 [1, 1, 0, 1, 0],
               )
Output: Team 2

[0, 0, 0, 0, 0] => Team 0 loses to all
[1, 0, 0, 0, 0] => Team 1 beats only Team 0
[1, 1, 0, 1, 1] => Team 2 beats everyone except self
[1, 1, 0, 0, 0] => Team 3 loses to Team 2
[1, 1, 0, 1, 0] => Team 4 loses to Team 2
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 19th October
   2025.
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

type ints []int

func (in ints) sum() int {
	sm := 0
	for _, v := range in {
		sm += v
	}
	return sm
}

type grid []ints

func (gd grid) process() int {
	mx := 0
	rank := make(ints, len(gd))
	for i, rw := range gd {
		v := rw.sum()
		rank[i] = v
		if mx < v {
			mx = v
		}
	}
	var top ints
	for i, v := range rank {
		if v == mx {
			top = append(top, i)
		}
	}
	l := len(top)
	if l == 1 {
		return top[0]
	}
	for i := 0; i < l-1; i++ {
		for j := i + 1; j < l; j++ {
			a, b := top[i], top[j]
			if gd[a][b] == 1 {
				return a
			}
			if gd[b][a] == 1 {
				return b
			}
		}
	}
	return -1
}

func main() {
	for _, data := range []struct {
		input  grid
		output int
	}{
		{
			grid{
				ints{0, 1, 1},
				ints{0, 0, 1},
				ints{0, 0, 0},
			}, 0},
		{
			grid{
				ints{0, 1, 0, 0},
				ints{0, 0, 0, 0},
				ints{1, 1, 0, 0},
				ints{1, 1, 1, 0},
			}, 3},
		{
			grid{
				ints{0, 1, 0, 1},
				ints{0, 0, 1, 1},
				ints{1, 0, 0, 0},
				ints{0, 0, 1, 0},
			}, 0},
		{
			grid{
				ints{0, 1, 1},
				ints{0, 0, 0},
				ints{0, 1, 0},
			}, 0},
		{
			grid{
				ints{0, 0, 0, 0, 0},
				ints{1, 0, 0, 0, 0},
				ints{1, 1, 0, 1, 1},
				ints{1, 1, 0, 0, 0},
				ints{1, 1, 0, 1, 0},
			}, 2},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
