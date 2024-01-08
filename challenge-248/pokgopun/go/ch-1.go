//# https://theweeklychallenge.org/blog/perl-weekly-challenge-248/
/*#

Task 1: Shortest Distance

Submitted by: [58]Mohammad S Anwar
     __________________________________________________________________

   You are given a string and a character in the given string.

   Write a script to return an array of integers of size same as length of
   the given string such that:
distance[i] is the distance from index i to the closest occurence of
the given character in the given string.

The distance between two indices i and j is abs(i - j).

Example 1

Input: $str = "loveleetcode", $char = "e"
Output: (3,2,1,0,1,0,0,1,2,2,1,0)

The character 'e' appears at indices 3, 5, 6, and 11 (0-indexed).
The closest occurrence of 'e' for index 0 is at index 3, so the distance is abs(
0 - 3) = 3.
The closest occurrence of 'e' for index 1 is at index 3, so the distance is abs(
1 - 3) = 2.
For index 4, there is a tie between the 'e' at index 3 and the 'e' at index 5,
but the distance is still the same: abs(4 - 3) == abs(4 - 5) = 1.
The closest occurrence of 'e' for index 8 is at index 6, so the distance is abs(
8 - 6) = 2.

Example 2

Input: $str = "aaab", $char = "b"
Output: (3,2,1,0)

Task 2: Submatrix Sum
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

type word string

func (w word) indexes(r rune) []int {
	idxs := []int{}
	for i, v := range w {
		if v == r {
			idxs = append(idxs, i)
		}
	}
	return idxs
}

func (w word) shortestDistance(r rune) []int {
	pos := w.indexes(r)
	if len(pos) == 0 {
		return []int{}
	}
	l := len(w)
	s := make([]int, l)
	var d, p int
	for l > 0 {
		l--
		s[l] = max(l, pos[0]) - min(l, pos[0])
		for _, p = range pos[1:] {
			d = max(l, p) - min(l, p)
			if d < s[l] {
				s[l] = d
			}
		}
	}
	return s
}

func main() {
	for _, data := range []struct {
		wrd    word
		lttr   rune
		dstnce []int
	}{
		{"loveleetcode", 'e', []int{3, 2, 1, 0, 1, 0, 0, 1, 2, 2, 1, 0}},
		{"aaab", 'b', []int{3, 2, 1, 0}},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.wrd.shortestDistance(data.lttr), data.dstnce)) // output nothing if ok, otherwise show the difference
	}
}
