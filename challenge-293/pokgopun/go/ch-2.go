//# https://theweeklychallenge.org/blog/perl-weekly-challenge-293/
/*#

Task 2: Boomerang

Submitted by: [41]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of points, (x, y).

   Write a script to find out if the given points are a boomerang.

     A boomerang is a set of three points that are all distinct and not
     in a straight line.

Example 1

Input: @points = ( [1, 1], [2, 3], [3,2] )
Output: true

Example 2

Input: @points = ( [1, 1], [2, 2], [3, 3] )
Output: false

Example 3

Input: @points = ( [1, 1], [1, 2], [2, 3] )
Output: true

Example 4

Input: @points = ( [1, 1], [1, 2], [1, 3] )
Output: false

Example 5

Input: @points = ( [1, 1], [2, 1], [3, 1] )
Output: false

Example 6

Input: @points = ( [0, 0], [2, 3], [4, 5] )
Output: true
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 3rd November
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

type point struct {
	x, y int
}

type points []point

func (ps points) isBoomerang() bool {
	l := len(ps)
	m := make(map[point]int)
	for _, v := range ps {
		m[v]++
	}
	if len(m) != l {
		return false
	}
	x := [2]int{ps[0].x, 0}
	y := [2]int{ps[0].y, 0}
	for _, p := range ps[1:] {
		if x[0] != p.x {
			x[1]++
		}
		if y[0] != p.y {
			y[1]++
		}
	}
	if x[1] == 0 || y[1] == 0 {
		return false
	}
	var deltas points
	for i := 0; i < l-1; i++ {
		for j := i + 1; j < l; j++ {
			deltas = append(deltas, point{ps[i].x - ps[j].x, ps[i].y - ps[j].y})
		}
	}
	l = len(deltas)
	//fmt.Println("=>", deltas)
	for i := 0; i < l-1; i++ {
		for j := i + 1; j < l; j++ {
			if deltas[i].x*deltas[j].y != deltas[i].y*deltas[j].x {
				return true
			}
		}
	}
	return false
}

func main() {
	for _, data := range []struct {
		input  points
		output bool
	}{
		{points{point{1, 1}, point{2, 3}, point{3, 2}}, true},
		{points{point{1, 1}, point{2, 2}, point{3, 3}}, false},
		{points{point{1, 1}, point{1, 2}, point{2, 3}}, true},
		{points{point{1, 1}, point{1, 2}, point{1, 3}}, false},
		{points{point{1, 1}, point{2, 1}, point{3, 1}}, false},
		{points{point{0, 0}, point{2, 3}, point{4, 5}}, true},
	} {
		//fmt.Println(data)
		io.WriteString(os.Stdout, cmp.Diff(data.input.isBoomerang(), data.output)) // blank if ok, otherwise show the difference
	}
}
