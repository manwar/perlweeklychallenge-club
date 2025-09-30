/*
# Task 2: Ascending Numbers
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string, $str, is a list of tokens separated by a single space. Every token is either a positive number consisting of digits 0-9 with no leading zeros, or a word consisting of lowercase English letters.
# Write a script to check if all the numbers in the given string are strictly increasing from left to right.
# 
# Example 1
# Input: $str = "The cat has 3 kittens 7 toys 10 beds"
# Output: true
# 
# Numbers 3, 7, 10 - strictly increasing.
# 
# Example 2
# Input: $str = 'Alice bought 5 apples 2 oranges 9 bananas'
# Output: false
# 
# Example 3
# Input: $str = 'I ran 1 mile 2 days 3 weeks 4 months'
# Output: true
# 
# Example 4
# Input: $str = 'Bob has 10 cars 10 bikes'
# Output: false
# 
# Example 5
# Input: $str = 'Zero is 0 one is 1 two is 2'
# Output: true
*/

package main

import (
  "fmt"
  "regexp"
  "strconv"
)

func Slice_Atoi(strArr []string) ([]int) {
    var str string
    var i int
    var err error

    iArr := make([]int, 0, len(strArr))
    for _, str = range strArr {
        i, err = strconv.Atoi(str)
        if err != nil {
            return nil
        }
        iArr = append(iArr, i)
    }
    return iArr
}

func checkSortedArray(arr []int) (bool) {
    sortedArray := true
    for i:=0; i<=len(arr)-1; i++ {
        for j:=0; j<len(arr)-1-i; j++ {
            if arr[j] >= arr[j+1]{
                sortedArray = false
                break
            }
        }
    }
    return sortedArray
}

func ascending_numbers(str string) {
    r := regexp.MustCompile(`\d+`)
	matches := r.FindAllString(str, -1)
    iMatches := Slice_Atoi(matches)
    fmt.Printf("'%s' -> %t\n", str, checkSortedArray(iMatches) )
}

func main() {
    str := "The cat has 3 kittens 7 toys 10 beds"
    ascending_numbers( str )

    str = "Alice bought 5 apples 2 oranges 9 bananas"
    ascending_numbers( str )

    str = "I ran 1 mile 2 days 3 weeks 4 months"
    ascending_numbers( str )

    str = "Bob has 10 cars 10 bikes"
    ascending_numbers( str )

    str = "Zero is 0 one is 1 two is 2"
    ascending_numbers( str )
}

