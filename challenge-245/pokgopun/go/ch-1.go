//# https://theweeklychallenge.org/blog/perl-weekly-challenge-245/
/*#

Task 1: Sort Language

Submitted by: [45]Mohammad S Anwar
     __________________________________________________________________

   You are given two array of languages and its popularity.

   Write a script to sort the language based on popularity.

Example 1

Input: @lang = ('perl', 'c', 'python')
       @popularity = (2, 1, 3)
Output: ('c', 'perl', 'python')

Example 2

Input: @lang = ('c++', 'haskell', 'java')
       @popularity = (1, 3, 2)
Output: ('c++', 'java', 'haskell')

Task 2: Largest of Three
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"cmp"
	"fmt"
	"reflect"
	"slices"
)

type ranks []int

type words []string

func (w words) sort(r ranks) words {
	slices.SortFunc(w, func(a, b string) int {
		return cmp.Compare(r[slices.Index(w, a)], r[slices.Index(w, b)])
	})
	return w
}

func main() {
	for _, data := range []struct {
		input1 words
		input2 ranks
		output words
	}{
		{words{"perl", "c", "python"}, ranks{2, 1, 3}, words{"c", "perl", "python"}},
		{words{"c++", "haskell", "java"}, ranks{1, 3, 2}, words{"c++", "java", "haskell"}},
	} {
		fmt.Println(reflect.DeepEqual(data.input1.sort(data.input2), data.output))
	}
}
