/*
# Task 1: Minimum Index Sum
# Submitted by: Mohammad S Anwar
# 
# You are given two arrays of strings.
# Write a script to find out all common strings in the given two arrays with minimum index sum. If no common strings found returns an empty list.
# 
# Example 1
# Input: @list1 = ("Perl", "Raku", "Love")
#        @list2 = ("Raku", "Perl", "Hate")
# Output: ("Perl", "Raku")
# 
# There are two common strings "Perl" and "Raku".
# Index sum of "Perl": 0 + 1 = 1
# Index sum of "Raku": 1 + 0 = 1
# 
# Example 2
# Input: @list1 = ("A", "B", "C")
#        @list2 = ("D", "E", "F")
# Output: ()
# 
# No common string found, so no result.
# 
# Example 3
# Input: @list1 = ("A", "B", "C")
#        @list2 = ("C", "A", "B")
# Output: ("A")
# 
# There are three common strings "A", "B" and "C".
# Index sum of "A": 0 + 1 = 1
# Index sum of "B": 1 + 2 = 3
# Index sum of "C": 2 + 0 = 2
*/

package main

import (
    "fmt"
)

func get_minimum_index_sum(list1 []string, list2 []string) []string {
    words := make([]string, 0)
    var value int = -1

    for i := 0; i <= len(list1)-1; i++ {
        for j := 0; j <= len(list2)-1; j++ {
            if value != -1 && value < i + j {
                break
            }
            if list1[i] == list2[j] {
                if value == -1 || value > i + j {
                    words = nil
                    value = i + j
                }
                words = append(words, list1[i])
            }
        }
    }
    return words
}

func main() {
    fmt.Println(get_minimum_index_sum([]string {"Perl", "Raku", "Love"},
                                      []string {"Raku", "Perl", "Hate"} ) )
    fmt.Println(get_minimum_index_sum([]string {"A", "B", "C"},
                                      []string {"D", "E", "F"} ) )
    fmt.Println(get_minimum_index_sum([]string {"A", "B", "C"},
                                      []string {"C", "A", "B"} ) )
}

