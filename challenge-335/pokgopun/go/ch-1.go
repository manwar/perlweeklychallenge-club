//# https://theweeklychallenge.org/blog/perl-weekly-challenge-335/
/*#

Task 1: Common Characters

Submitted by: [41]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of words.

   Write a script to return all characters that is in every word in the
   given array including duplicates.

Example 1

Input: @words = ("bella", "label", "roller")
Output: ("e", "l", "l")

Example 2

Input: @words = ("cool", "lock", "cook")
Output: ("c", "o")

Example 3

Input: @words = ("hello", "world", "pole")
Output: ("l", "o")

Example 4

Input: @words = ("abc", "def", "ghi")
Output: ()

Example 5

Input: @words = ("aab", "aac", "aaa")
Output: ("a", "a")

Task 2: Find Winner
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"github.com/google/go-cmp/cmp"
	"io"
	"os"
	"slices"
)

func cc(words []string) []rune {
	res := []rune{}
	rmn := [][]rune{}
	for _, v := range words[1:] {
		rmn = append(rmn, []rune(v))
	}
	l := len(rmn)
	for _, v := range words[0] {
		i := 0
		for i < l {
			j := slices.Index(rmn[i], v)
			if j < 0 {
				break
			}
			copy(rmn[i][j:], rmn[i][j+1:])
			rmn[i] = rmn[i][:len(rmn[i])-1]
			i++
		}
		if i == l {
			res = append(res, v)
		}
	}
	return res
}

func main() {
	for _, data := range []struct {
		input  []string
		output []rune
	}{
		{[]string{"bella", "label", "roller"}, []rune{'e', 'l', 'l'}},
		{[]string{"cool", "lock", "cook"}, []rune{'c', 'o'}},
		{[]string{"hello", "world", "pole"}, []rune{'l', 'o'}},
		{[]string{"abc", "def", "ghi"}, []rune{}},
		{[]string{"aab", "aac", "aaa"}, []rune{'a', 'a'}},
		{[]string{"กาลก่อน", "กรรมตามทันมาก", "กากี"}, []rune{'ก', 'า', 'ก'}},
		{[]string{"รอทัก", "รับกรรม", "ปรปักษ์"}, []rune{'ร', 'ั', 'ก'}},
	} {
		io.WriteString(os.Stdout, cmp.Diff(cc(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
