/*
Task 2: Relative Sort
Submitted by: Mohammad Sajid Anwar

You are given two list of integers, @list1 and @list2. The elements in the @list2 are distinct and also in the @list1.
Write a script to sort the elements in the @list1 such that the relative order of items in @list1 is same as in the @list2. Elements that is missing in @list2 should be placed at the end of @list1 in ascending order.

Example 1
Input: @list1 = (2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5)
       @list2 = (2, 1, 4, 3, 5, 6)
Ouput: (2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9)

Example 2
Input: @list1 = (3, 3, 4, 6, 2, 4, 2, 1, 3)
       @list2 = (1, 3, 2)
Ouput: (1, 3, 3, 3, 2, 2, 4, 4, 6)

Example 3
Input: @list1 = (3, 0, 5, 0, 2, 1, 4, 1, 1)
       @list2 = (1, 0, 3, 2)
Ouput: (1, 1, 1, 0, 0, 3, 2, 4, 5)
*/

package main

import (
  "fmt"
  "sort"
)

func sort_keys(freq map[int]int) []int {
    keys := make([]int, 0, len(freq))
    for k := range freq{
        keys = append(keys, k)
    }
    sort.Ints(keys)
    return keys
}

func relative_sort(list1 []int, list2[]int) {
    freq := make(map[int]int)
    for _, num := range list1 {
        freq[num] = freq[num]+1
    }

    var list3 []int
    for _, num := range list2 {
        _, ok := freq[num]
        if ok {
            for i := 1; i <= freq[num]; i++ {
                list3 = append(list3, num)
            }
            delete(freq, num)
        }
    }

    keys_ordered := sort_keys(freq)

    for _, num := range keys_ordered {
        for i := 1; i <= freq[num]; i++ {
            list3 = append(list3, num)
        }
    }
    fmt.Printf("list1 %v\nlist2 %v\n\t-> %d\n\n", list1, list2, list3)
}

func main() {
    list1 := []int{2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5}
    list2 := []int{2, 1, 4, 3, 5, 6}
    relative_sort(list1, list2)

    list1 = []int{3, 3, 4, 6, 2, 4, 2, 1, 3}
    list2 = []int{1, 3, 2}
    relative_sort(list1, list2)

    list1 = []int{3, 0, 5, 0, 2, 1, 4, 1, 1}
    list2 = []int{1, 0, 3, 2}
    relative_sort(list1, list2)
}
