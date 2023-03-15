/*
# Task 2: Duplicate and Missing
# Submitted by: Mohammad S Anwar
# 
# You are given an array of integers in sequence with one missing and one duplicate.
# Write a script to find the duplicate and missing integer in the given array. Return -1 if none found.
# For the sake of this task, let us assume the array contains no more than one duplicate and missing.
# 
# Example 1:
# Input: @nums = (1,2,2,4)
# Output: (2,3)
# Duplicate is 2 and Missing is 3.
# 
# Example 2:
# Input: @nums = (1,2,3,4)
# Output: -1
# No duplicate and missing found.
# 
# Example 3:
# Input: @nums = (1,2,3,3)
# Output: (3,4)
# Duplicate is 3 and Missing is 4.
*/

package main

import (
    "fmt"
    "sort"
)

func skip_1_value(list1 []int, index int) []int {
    skip_1_value := make([]int, 0)
    for i, _ := range list1 {
        if i == index {
            continue
        }
        skip_1_value = append(skip_1_value, list1[i])
    }
    return skip_1_value
}

func duplicate_and_missing(list1 []int) []int {
    dupl_and_miss := make([]int, 0)

    for i, val := range list1 {
        numbers := skip_1_value(list1, i)
        pos := sort.SearchInts(numbers, val)
        if pos < len(numbers) && numbers[pos] == val {  // found
	    dupl_and_miss = append(dupl_and_miss, val)
            break
        }
    }
    for i := 0; i <= len(list1)-1; i++ {
        val := list1[0] + i
        pos := sort.SearchInts(list1, val)
        if !(pos < len(list1) && list1[pos] == val) {   // not found
	    dupl_and_miss = append(dupl_and_miss, val)
        }
    }
    return dupl_and_miss
}

func main() {
    fmt.Println(duplicate_and_missing([]int {1,2,2,4} ) )
    fmt.Println(duplicate_and_missing([]int {1,2,3,4} ) )
    fmt.Println(duplicate_and_missing([]int {1,2,3,3} ) )
}


