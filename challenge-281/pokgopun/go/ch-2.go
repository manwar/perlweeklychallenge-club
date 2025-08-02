//# https://theweeklychallenge.org/blog/perl-weekly-challenge-281/
/*#

Task 2: Knight’s Move

Submitted by: [48]Peter Campbell Smith
     __________________________________________________________________

   A Knight in chess can move from its current position to any square two
   rows or columns plus one column or row away. So in the diagram below,
   if it starts a S, it can move to any of the squares marked E.

   Write a script which takes a starting position and an ending position
   and calculates the least number of moves required.

   Week_281_Task_2

Example 1

Input: $start = 'g2', $end = 'a8'
Ouput: 4

g2 -> e3 -> d5 -> c7 -> a8

Example 2

Input: $start = 'g2', $end = 'h2'
Ouput: 3

g2 -> e3 -> f1 -> h2
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 11th August
   2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com
// https://afteracademy.com/blog/knight-on-chessboard/#:~:text=Solution,the%20shape%20of%20an%20L).

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

type position struct {
	x, y int
}

func newPosition(label string) position {
	return position{int(label[0]) - 96, int(label[1]) - 48}
}

func (pt position) String() string {
	return string([]byte{byte(pt.x) + 96, byte(pt.y) + 48})
}

type data struct {
	count   int
	visited bool
}

type board [8][8]data

func (bd board) contains(p position) bool {
	return p.x >= 1 && p.x <= 8 && p.y >= 1 && p.y <= 8
}

func knightMove(start, end string) int {
	var bd board
	p0 := newPosition(start)
	p1 := newPosition(end)
	queue := []position{p0}
	bd[p0.x-1][p0.y-1] = data{visited: true}
	dx := [8]int{-2, -1, 1, 2, -2, -1, 1, 2}
	dy := [8]int{-1, -2, -2, -1, 1, 2, 2, 1}
	for len(queue) > 0 {
		p := queue[0]
		queue = queue[1:]
		if p.x == p1.x && p.y == p1.y {
			return bd[p.x-1][p.y-1].count
		}
		for i := 0; i < 8; i++ {
			pn := position{p.x + dx[i], p.y + dy[i]}
			if bd.contains(pn) && !bd[pn.x-1][pn.y-1].visited {
				bd[pn.x-1][pn.y-1] = data{visited: true, count: bd[p.x-1][p.y-1].count + 1}
				queue = append(queue, pn)
			}
		}
	}
	return -1
}

func main() {
	for _, data := range []struct {
		start, end string
		count      int
	}{
		{"g2", "a8", 4},
		{"g2", "h2", 3},
	} {
		io.WriteString(os.Stdout, cmp.Diff(knightMove(data.start, data.end), data.count)) // blank if ok, otherwise show the difference
	}
}
