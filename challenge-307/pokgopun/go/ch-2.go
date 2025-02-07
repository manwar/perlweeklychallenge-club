//# https://theweeklychallenge.org/blog/perl-weekly-challenge-307/
/*#

Task 2: Find Anagrams

Submitted by: [43]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a list of words, @words.

   Write a script to find any two consecutive words and if they are
   anagrams, drop the first word and keep the second. You continue this
   until there is no more anagrams in the given list and return the count
   of final list.

Example 1

Input: @words = ("acca", "dog", "god", "perl", "repl")
Output: 3

Step 1: "dog" and "god" are anagrams, so dropping "dog" and keeping "god" => ("a
cca", "god", "perl", "repl")
Step 2: "perl" and "repl" are anagrams, so dropping "perl" and keeping "repl" =>
 ("acca", "god", "repl")

Example 2

Input: @words = ("abba", "baba", "aabb", "ab", "ab")
Output: 2

Step 1: "abba" and "baba" are anagrams, so dropping "abba" and keeping "baba" =>
 ("baba", "aabb", "ab", "ab")
Step 2: "baba" and "aabb" are anagrams, so dropping "baba" and keeping "aabb" =>
 ("aabb", "ab", "ab")
Step 3: "ab" and "ab" are anagrams, so dropping "ab" and keeping "ab" => ("aabb"
, "ab")
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 9^th February
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

type word string

func (w word) isAnagram(wrd word) bool {
	if len(w) != len(wrd) {
		return false
	}
	m := make(map[rune]int)
	for _, v := range wrd {
		m[v]++
	}
	for _, v := range w {
		m[v]--
		if m[v] == 0 {
			delete(m, v)
		}
	}
	return len(m) == 0
}

type words []word

func findAnagrams(ws words) int {
	i := 0
	for {
		if i+1 >= len(ws) {
			break
		}
		if ws[i].isAnagram(ws[i+1]) {
			copy((ws)[i:], ws[i+1:])
			ws = ws[:len(ws)-1]
		} else {
			i++
		}
	}
	//fmt.Println(ws)
	return len(ws)
}

func main() {
	for _, data := range []struct {
		input  words
		output int
	}{
		{words{"acca", "dog", "god", "perl", "repl"}, 3},
		{words{"abba", "baba", "aabb", "ab", "ab"}, 2},
	} {
		io.WriteString(os.Stdout, cmp.Diff(findAnagrams(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
