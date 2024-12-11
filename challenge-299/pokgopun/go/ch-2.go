//# https://theweeklychallenge.org/blog/perl-weekly-challenge-299/
/*#

Task 2: Word Search

Submitted by: [50]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a grid of characters and a string.

   Write a script to determine whether the given string can be found in
   the given grid of characters. You may start anywhere and take any
   orthogonal path, but may not reuse a grid cell.

Example 1

Input: @chars = (['A', 'B', 'D', 'E'],
                 ['C', 'B', 'C', 'A'],
                 ['B', 'A', 'A', 'D'],
                 ['D', 'B', 'B', 'C'])
      $str = 'BDCA'
Output: true

Example 2

Input: @chars = (['A', 'A', 'B', 'B'],
                 ['C', 'C', 'B', 'A'],
                 ['C', 'A', 'A', 'A'],
                 ['B', 'B', 'B', 'B'])
      $str = 'ABAC'
Output: false

Example 3

Input: @chars = (['B', 'A', 'B', 'A'],
                 ['C', 'C', 'C', 'C'],
                 ['A', 'B', 'A', 'B'],
                 ['B', 'B', 'A', 'A'])
      $str = 'CCCAA'
Output: true
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 15^th December
   2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"slices"

	"github.com/google/go-cmp/cmp"
)

type point struct {
	r, c int
}

type row []rune

type rows []row

type processor struct {
	rws       rows
	h, w      int
	strRunes  []rune
	l         int
	strPs     []point
	strExists bool
}

func newProcessor(rws rows, str string) processor {
	pcs := processor{rws: rws, h: len(rws), w: len(rws[0]), strRunes: []rune(str)}
	pcs.l = len(pcs.strRunes)
	if pcs.l == 0 {
		return pcs
	}
	pcs.strPs = make([]point, pcs.l)
	for r := range pcs.h {
		for c := range pcs.w {
			if rws[r][c] == pcs.strRunes[0] {
				pcs.strPs[0] = point{r, c}
				if pcs.process(1) == pcs.l {
					//fmt.Println(pcs.strPs)
					pcs.strExists = true
					return pcs
				}
			}
		}
	}
	//fmt.Println(pcs.strPs)
	return pcs
}

func (pcs processor) adjacentPoints(p point) []point {
	ps := []point{}
	if p.r > 0 {
		ps = append(ps, point{p.r - 1, p.c})
	}
	if p.c > 0 {
		ps = append(ps, point{p.r, p.c - 1})
	}
	if p.r < pcs.h-1 {
		ps = append(ps, point{p.r + 1, p.c})
	}
	if p.c < pcs.w-1 {
		ps = append(ps, point{p.r, p.c + 1})
	}
	return ps
}

func (pcs processor) process(idx int) int {
	if idx < pcs.l {
		for _, p := range pcs.adjacentPoints(pcs.strPs[idx-1]) {
			if pcs.rws[p.r][p.c] == pcs.strRunes[idx] && !slices.Contains(pcs.strPs[:idx], p) {
				pcs.strPs[idx] = p
				if pcs.process(idx+1) == pcs.l {
					return pcs.l
				}
			}
		}
	}
	return idx
}

func main() {
	for _, data := range []struct {
		rws    rows
		str    string
		output bool
	}{
		{rows{
			row{'A', 'B', 'D', 'E'},
			row{'C', 'B', 'C', 'A'},
			row{'B', 'A', 'A', 'D'},
			row{'D', 'B', 'B', 'C'},
		}, "BDCA", true},
		{rows{
			row{'A', 'A', 'B', 'B'},
			row{'C', 'C', 'B', 'A'},
			row{'C', 'A', 'A', 'A'},
			row{'B', 'B', 'B', 'B'},
		}, "ABAC", false},
		{rows{
			row{'B', 'A', 'B', 'A'},
			row{'C', 'C', 'C', 'C'},
			row{'A', 'B', 'A', 'B'},
			row{'B', 'B', 'A', 'A'},
		}, "CCCAA", true},
		{rows{
			row{'A', 'A', 'B', 'B'},
			row{'C', 'C', 'B', 'A'},
			row{'C', 'A', 'A', 'A'},
			row{'B', 'B', 'B', 'B'},
		}, "BABA", true},
	} {
		//fmt.Println(data)
		io.WriteString(os.Stdout, cmp.Diff(newProcessor(data.rws, data.str).strExists, data.output)) // blank if ok, otherwise show the difference
	}
}
