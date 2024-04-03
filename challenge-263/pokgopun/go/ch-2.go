//# https://theweeklychallenge.org/blog/perl-weekly-challenge-263/
/*#

Task 2: Merge Items

Submitted by: [48]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given two 2-D array of positive integers, $items1 and $items2
   where element is pair of (item_id, item_quantity).

   Write a script to return the merged items.

Example 1

Input: $items1 = [ [1,1], [2,1], [3,2] ]
       $items2 = [ [2,2], [1,3] ]
Output: [ [1,4], [2,3], [3,2] ]

Item id (1) appears 2 times: [1,1] and [1,3]. Merged item now (1,4)
Item id (2) appears 2 times: [2,1] and [2,2]. Merged item now (2,3)
Item id (3) appears 1 time: [3,2]

Example 2

Input: $items1 = [ [1,2], [2,3], [1,3], [3,2] ]
       $items2 = [ [3,1], [1,3] ]
Output: [ [1,8], [2,3], [3,3] ]

Example 3

Input: $items1 = [ [1,1], [2,2], [3,3] ]
       $items2 = [ [2,3], [2,4] ]
Output: [ [1,1], [2,9], [3,3] ]
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 7th April 2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"sort"

	"github.com/google/go-cmp/cmp"
)

type Item struct {
	Id, Qty int
}

type Items []Item

type ItemInv map[int]int

func (ii ItemInv) addItems(its Items) {
	for _, it := range its {
		ii[it.Id] += it.Qty
	}
}

func (ii ItemInv) items() Items {
	l := len(ii)
	its := make(Items, l)
	for k, v := range ii {
		l--
		its[l] = Item{k, v}
	}
	sort.Slice(its, func(a, b int) bool {
		return its[a].Id < its[b].Id
	})
	return its
}

func main() {
	ii := make(ItemInv)
	for _, data := range []struct {
		items1, items2, merged Items
	}{
		{Items{Item{1, 1}, Item{2, 1}, Item{3, 2}}, Items{Item{2, 2}, Item{1, 3}}, Items{Item{1, 4}, Item{2, 3}, Item{3, 2}}},
		{Items{Item{1, 2}, Item{2, 3}, Item{1, 3}, Item{3, 2}}, Items{Item{3, 1}, Item{1, 3}}, Items{Item{1, 8}, Item{2, 3}, Item{3, 3}}},
		{Items{Item{1, 1}, Item{2, 2}, Item{3, 3}}, Items{Item{2, 3}, Item{2, 4}}, Items{Item{1, 1}, Item{2, 9}, Item{3, 3}}},
	} {
		ii.addItems(data.items1)
		ii.addItems(data.items2)
		//fmt.Println(ii.items(), data.merged)
		io.WriteString(os.Stdout, cmp.Diff(ii.items(), data.merged)) // blank if ok, otherwise show the difference
		clear(ii)
	}
}
