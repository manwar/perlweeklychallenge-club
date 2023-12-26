//# https://theweeklychallenge.org/blog/perl-weekly-challenge-249/
/*#

Task 1: Shortest Distance

Submitted by: [66]Mohammad S Anwar
     __________________________________________________________________

   You are given an array of integers with even number of elements.

   Write a script to divide the given array into equal pairs such that:
a) Each element belongs to exactly one pair.
b) The elements present in a pair are equal.

Example 1

Input: @ints = (3, 2, 3, 2, 2, 2)
Output: (2, 2), (3, 3), (2, 2)

There are 6 elements in @ints.
They should be divided into 6 / 2 = 3 pairs.
@ints is divided into the pairs (2, 2), (3, 3), and (2, 2) satisfying all the co
nditions.

Example 2

Input: @ints = (1, 2, 3, 4)
Output: ()

There is no way to divide @ints 2 pairs such that the pairs satisfy every condit
ion.

Task 2: DI String Match
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"cmp"
	"fmt"
	"slices"

	gocmp "github.com/google/go-cmp/cmp"
)

type duo [2]int

type duos []duo

func (ds duos) sort() duos {
	if len(ds) == 0 {
		return nil
	}
	slices.SortFunc(ds, func(a, b duo) int {
		return cmp.Compare(a[0], b[0])
	})
	return ds
}

type ints []int

func (is ints) equalPairs() duos {
	var ds duos
	slices.Sort(is)
	m := make(map[int]int)
	for _, v := range is {
		m[v]++
		if m[v] == 2 {
			ds = append(ds, duo{v, v})
			m[v] = 0
		}
	}
	//return ds.sort()
	return ds
}

func main() {
	for _, data := range []struct {
		input  ints
		output duos
	}{
		{ints{3, 2, 3, 2, 2, 2}, duos{duo{2, 2}, duo{3, 3}, duo{2, 2}}},
		{ints{1, 2, 3, 4}, duos{}},
	} {
		fmt.Println(gocmp.Diff(data.input.equalPairs(), data.output.sort())) //output nothing if ok, otherise show the difference
	}
}
