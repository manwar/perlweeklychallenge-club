// https://theweeklychallenge.org/blog/perl-weekly-challenge-233/
/*
Task 1: Similar Words

Submitted by: [43]Mohammad S Anwar
     __________________________________________________________________

   You are given an array of words made up of alphabets only.

   Write a script to find the number of pairs of similar words. Two words
   are similar if they consist of the same characters.

Example 1

Input: @words = ("aba", "aabb", "abcd", "bac", "aabc")
Output: 2

Pair 1: similar words ("aba", "aabb")
Pair 2: similar words ("bac", "aabc")

Example 2

Input: @words = ("aabb", "ab", "ba")
Output: 3

Pair 1: similar words ("aabb", "ab")
Pair 2: similar words ("aabb", "ba")
Pair 3: similar words ("ab", "ba")

Example 3

Input: @words = ("nba", "cba", "dba")
Output: 0
*/
package main

import (
	"fmt"
	"slices"
)

func main() {
	for _, data := range []struct {
		input  []string
		output int
	}{
		{[]string{"aba", "aabb", "abcd", "bac", "aabc"}, 2},
		{[]string{"aabb", "ab", "ba"}, 3},
		{[]string{"nba", "cba", "dba"}, 0},
	} {
		fmt.Println(countSimilar(data.input) == data.output)
	}
}

func countSimilar(s []string) (count int) {
	m := map[string]int{}
	for _, v := range s {
		m[chrFrmStr(v)]++
	}
	//fmt.Println(m)
	for _, v := range m {
		if v > 1 {
			//fmt.Println(v, "=>", factorial(v))
			count += factorial(v) / (2 * factorial(v-2))
		}
	}
	return count
}

func chrFrmStr(s string) string {
	bs := []byte(s)
	slices.Sort(bs)
	//fmt.Printf("'%s' is sorted to '%s',and then deduped to ", s, string(bs))
	l := len(bs)
	i, j := 0, l
	for j > 1 {
		if bs[i] == bs[i+1] {
			copy(bs[i:], bs[i+1:])
			l--
		} else {
			i++
		}
		j--
	}
	//fmt.Printf("'%s'\n", string(bs[:l]))
	return string(bs[:l])
}

func factorial(n int) int {
	f := 1
	for i := 2; i <= n; i++ {
		f *= i
	}
	return f
}
