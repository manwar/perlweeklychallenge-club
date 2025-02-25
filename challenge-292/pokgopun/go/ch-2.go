//# https://theweeklychallenge.org/blog/perl-weekly-challenge-292/
/*#

Task 2: Zuma Game

Submitted by: [48]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a single row of colored balls, $row and a random number
   of colored balls in $hand.

   Here is the variation of Zuma game as your goal is to clear all of the
   balls from the board. Pick any ball from your hand and insert it in
   between two balls in the row or on either end of the row. If there is a
   group of three or more consecutive balls of the same color then remove
   the group of balls from the board. If there are no more balls on the
   board then you win the game. Repeat this process until you either win
   or do not have any more balls in your hand.

   Write a script to minimum number of balls you have to insert to clear
   all the balls from the board. If you cannot clear all the balls from
   the board using the balls in your hand, return -1.

Example 1

Input: $board = "WRRBBW", $hand = "RB"
Output: -1

It is impossible to clear all the balls. The best you can do is:
- Insert 'R' so the board becomes WRRRBBW. WRRRBBW -> WBBW.
- Insert 'B' so the board becomes WBBBW. WBBBW -> WW.
There are still balls remaining on the board, and you are out of balls to insert
.

Example 2

Input: $board = "WWRRBBWW", $hand = "WRBRW"
Output: 2

To make the board empty:
- Insert 'R' so the board becomes WWRRRBBWW. WWRRRBBWW -> WWBBWW.
- Insert 'B' so the board becomes WWBBBWW. WWBBBWW -> WWWW -> empty.
2 balls from your hand were needed to clear the board.

Example 3

Input: $board = "G", $hand = "GGGGG"
Output: 2

To make the board empty:
- Insert 'G' so the board becomes GG.
- Insert 'G' so the board becomes GGG. GGG -> empty.
2 balls from your hand were needed to clear the board.
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 27th October
   2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"maps"
	"os"

	"github.com/google/go-cmp/cmp"
)

type color rune

type cluster struct {
	color color
	count int
}

type board []cluster

func newBoard(str string) board {
	if str == "" {
		return board{}
	}
	var (
		b       board
		c_color rune
		c_count int
	)
	for _, v := range str {
		if v == c_color {
			c_count++
		} else {
			if c_color != 0 && c_count < 3 {
				b = append(b, cluster{color(c_color), c_count})
			}
			c_color = v
			c_count = 1
		}
	}
	if c_color != 0 && c_count < 3 {
		b = append(b, cluster{color(c_color), c_count})
	}
	return b
}

func (b board) clear(i int) board {
	l := len(b)
	if i >= l {
		return board{}
	}
	switch i {
	case 0:
		return b[1:]
	case l - 1:
		return b[:l-1]
	}
	if b[i-1].color == b[i+1].color {
		b[i-1].count += b[i+1].count
		copy(b[i:], b[i+2:])
		b = b[:l-2]
		if b[i-1].count > 2 {
			return b.clear(i - 1)
		}
	} else {
		copy(b[i:], b[i+1:])
		b = b[:l-1]
	}
	return b
}

type processor struct {
	b board
	h map[color]int
}

func newProcessor(board, hand string) processor {
	p := processor{b: newBoard(board)}
	if hand != "" {
		h := make(map[color]int)
		for _, v := range hand {
			h[color(v)]++
		}
		p.h = h
	}
	return p
}

func (p processor) notdeadyet() bool {
	m := make(map[color]int)
	for _, v := range p.b {
		m[v.color] += v.count
	}
	for k, v := range m {
		v += p.h[k]
		if v < 3 {
			return false
		}
	}
	return true
}

func (p processor) resolve() int {
	if len(p.b) == 0 {
		return 0
	}
	count := -1
	for i, v := range p.b {
		cost := 3 - v.count
		if p.h[v.color] < cost {
			continue
		}
		b := make(board, len(p.b))
		copy(b, p.b)
		b = b.clear(i)
		h := maps.Clone(p.h)
		h[v.color] -= cost
		pp := processor{b, h}
		if !pp.notdeadyet() {
			continue
		}
		c := pp.resolve()
		if c < 0 {
			continue
		}
		if count < 0 {
			count = cost + c
		} else {
			count = min(count, cost+c)
		}
	}
	return count
}

func main() {
	for _, data := range []struct {
		board, hand string
		count       int
	}{
		{"WRRBBW", "RB", -1},
		{"WWRRBBWW", "WRBRW", 2},
		{"G", "GGGGG", 2},
		{"RWWRRWR", "RWR", 2},
		{"WWRRWW", "RW", 1},
		{"GRGBGG", "RRBBG", 4},
		{"DAABABBDD", "DDCCBBAAA", 3},
	} {
		io.WriteString(os.Stdout, cmp.Diff(newProcessor(data.board, data.hand).resolve(), data.count)) // blank if ok, otherwise show the difference
	}
}
