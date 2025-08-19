//# https://theweeklychallenge.org/blog/perl-weekly-challenge-335/
/*#

Task 2: Find Winner

Submitted by: [42]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of all moves by the two players.

   Write a script to find the winner of the TicTacToe game if found based
   on the moves provided in the given array.

Example 1

Input: @moves = ([0,0],[2,0],[1,1],[2,1],[2,2])
Output: A

Game Board:
[ A _ _ ]
[ B A B ]
[ _ _ A ]

Example 2

Input: @moves = ([0,0],[1,1],[0,1],[0,2],[1,0],[2,0])
Output: B

Game Board:
[ A A B ]
[ A B _ ]
[ B _ _ ]

Example 3

Input: @moves = ([0,0],[1,1],[2,0],[1,0],[1,2],[2,1],[0,1],[0,2],[2,2])
Output: Draw

Game Board:
[ A A B ]
[ B B A ]
[ A B A ]

Example 4

Input: @moves = ([0,0],[1,1])
Output: Pending

Game Board:
[ A _ _ ]
[ _ B _ ]
[ _ _ _ ]

Example 5

Input: @moves = ([1,1],[0,0],[2,2],[0,1],[1,0],[0,2])
Output: B

Game Board:
[ B B B ]
[ A A _ ]
[ _ _ A ]
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 25th August
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"github.com/google/go-cmp/cmp"
	"io"
	"os"
)

type Result int

const (
	A Result = iota
	B
	Draw
	Pending
	InputError
)

type Move struct {
	x, y int
}

type Moves []Move

func (ms Moves) Process() Result {
	m2p := make(map[Move]int)
	for i, v := range ms {
		for _, e := range []int{v.x,v.y}{
			if e < 0 || e > 2 {
				return InputError
			}
		}
		if i%2 == 0 {
			m2p[v]++
		} else {
			m2p[v]--
		}
	}
	if len(ms) != len(m2p) {
		return InputError
	}
	res := Draw
	type score []int
	var scores []score
	var scoredd, scoreda score
	for i := range 3 {
		var scoreh, scorev score
		for e := range 3 {
			scoreh = append(scoreh, m2p[Move{e, i}])
			scorev = append(scorev, m2p[Move{i, e}])
		}
		scores = append(scores, scoreh, scorev)
		scoredd = append(scoredd, m2p[Move{i, i}])
		scoreda = append(scoreda, m2p[Move{i, 2 - i}])
	}
	for _, v := range append(scores, scoredd, scoreda) {
		var c, s int
		for _, p := range v {
			if p != 0 {
				c++
				s += p
			}
		}
		if c < 2 {
			res = Pending
			continue
		}
		switch s {
		case 3:
			return A
		case -3:
			return B
		case 2, -2:
			res = Pending
		}
	}
	return res
}

func main() {
	for _, data := range []struct {
		input  Moves
		output Result
	}{
		{Moves{Move{0, 0}, Move{2, 0}, Move{1, 1}, Move{2, 1}, Move{2, 2}}, A},
		{Moves{Move{0, 0}, Move{1, 1}, Move{0, 1}, Move{0, 2}, Move{1, 0}, Move{2, 0}}, B},
		{Moves{Move{0, 0}, Move{1, 1}, Move{2, 0}, Move{1, 0}, Move{1, 2}, Move{2, 1}, Move{0, 1}, Move{0, 2}, Move{2, 2}}, Draw},
		{Moves{Move{0, 0}, Move{1, 1}}, Pending},
		{Moves{Move{1, 1}, Move{0, 0}, Move{2, 2}, Move{0, 1}, Move{1, 0}, Move{0, 2}}, B},
		{Moves{Move{1, 1}, Move{0, 0}, Move{1, 1}, Move{0, 1}, Move{1, 0}, Move{0, 2}}, InputError},
		{Moves{Move{1, 1}, Move{0, 0}, Move{2, 2}, Move{2, 2}, Move{1, 0}, Move{0, 2}}, InputError},
		{Moves{Move{1, 1}, Move{0, 0}, Move{2, 2}, Move{3, 1}, Move{1, 0}, Move{0, 2}}, InputError},
		{Moves{Move{1, 1}, Move{0, 0}, Move{2, 2}, Move{0, 1}, Move{1, -1}, Move{0, 2}}, InputError},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.Process(), data.output)) // blank if ok, otherwise show the difference
	}
}
