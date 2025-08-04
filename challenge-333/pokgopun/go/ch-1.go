//# https://theweeklychallenge.org/blog/perl-weekly-challenge-333/
/*#

Task 1: Straight Line

Submitted by: [43]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a list of co-ordinates.

   Write a script to find out if the given points make a straight line.

Example 1

Input: @list = ([2, 1], [2, 3], [2, 5])
Output: true

Example 2

Input: @list = ([1, 4], [3, 4], [10, 4])
Output: true

Example 3

Input: @list = ([0, 0], [1, 1], [2, 3])
Output: false

Example 4

Input: @list = ([1, 1], [1, 1], [1, 1])
Output: true

Example 5

Input: @list = ([1000000, 1000000], [2000000, 2000000], [3000000, 3000000])
Output: true

Task 2: Duplicate Zeros
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"github.com/google/go-cmp/cmp"
	"io"
	"os"
)

type Point struct {
	x, y int
}

func (pnt Point) Slope(p Point) Slope {
	return Slope{pnt.y - p.y, pnt.x - p.x}
}

type Slope struct {
	y, x int
}

func (slp Slope) IsEqual(s Slope) bool {
	return slp.x*s.y == slp.y*s.x
}

type Input []Point

func (in Input) process() bool {
	i := len(in) - 1
	if i < 2 {
		return true
	}
	s0 := in[0].Slope(in[1])
	for i > 1 {
		if !s0.IsEqual(in[0].Slope(in[i])){
			return false
		}
		i--
	}
	return true
}

func main() {
	for _, data := range []struct {
		input  Input
		output bool
	}{
		{Input{Point{2, 1}, Point{2, 3}, Point{2, 5}}, true},
		{Input{Point{1, 4}, Point{3, 4}, Point{10, 4}}, true},
		{Input{Point{0, 0}, Point{1, 1}, Point{2, 3}}, false},
		{Input{Point{1, 1}, Point{1, 1}, Point{1, 1}}, true},
		{Input{Point{1000000, 1000000}, Point{2000000, 2000000}, Point{3000000, 3000000}}, true},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
