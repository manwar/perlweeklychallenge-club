//# https://theweeklychallenge.org/blog/perl-weekly-challenge-234/
/*#

Task 1: Common Characters

Submitted by: [43]Mohammad S Anwar
     __________________________________________________________________

   You are given an array of words made up of alphabetic characters only.

   Write a script to return all alphabetic characters that show up in all
   words including duplicates.

Example 1

Input: @words = ("java", "javascript", "julia")
Output: ("j", "a")

Example 2

Input: @words = ("bella", "label", "roller")
Output: ("e", "l", "l")

Example 3

Input: @words = ("cool", "lock", "cook")
Output: ("c", "o")

Task 2: Unequal Triplets
#*/

package main

import (
	"fmt"
	"slices"
	"strings"
)

func main() {
	var mw mwords
	for _, data := range []struct {
		input  []string
		output []rune
	}{
		{[]string{"java", "javascript", "julia"}, []rune{'j', 'a'}},
		{[]string{"bella", "label", "roller"}, []rune{'e', 'l', 'l'}},
		{[]string{"cool", "lock", "cook"}, []rune{'c', 'o'}},
	} {
		mw.words = data.input
		fmt.Println(slices.Equal(mw.commonChars(), data.output))
	}
}

type mchar struct {
	chr rune
	cnt int
}

type mwords struct {
	words []string
	word0 []mchar
}

func (mw mwords) commonChars() (r []rune) {
	for _, c := range mw.words[0] {
		mw.word0 = append(mw.word0, mchar{c, 1})
	}
	//fmt.Println(mw.word0)
	for _, w := range mw.words[1:] {
		for i := range mw.word0 {
			ri := strings.IndexRune(w, mw.word0[i].chr)
			if ri != -1 {
				mw.word0[i].cnt++
				w = string(slices.Delete([]rune(w), ri, ri+1))
			}
		}
	}
	//fmt.Println(mc)
	l := len(mw.words)
	for _, v := range mw.word0 {
		if v.cnt == l {
			r = append(r, v.chr)
		}
	}
	return r
}
