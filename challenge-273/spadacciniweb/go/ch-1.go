/*
Task 1: Percentage of Character
Submitted by: Mohammad Sajid Anwar

You are given a string, $str and a character $char.
Write a script to return the percentage, nearest whole, of given character in the given string.

Example 1
Input: $str = "perl", $char = "e"
Output: 25

Example 2
Input: $str = "java", $char = "a"
Output: 50

Example 3
Input: $str = "python", $char = "m"
Output: 0

Example 4
Input: $str = "ada", $char = "a"
Output: 67

Example 5
Input: $str = "ballerina", $char = "l"
Output: 22

Example 6
Input: $str = "analitik", $char = "k"
Output: 13
*/

package main

import (
    "fmt"
)

func percentage(str string, char string) {
    frequency := make(map[rune]int)

    for _, val := range str {
	frequency[val]++ //assign frequencies 
    }

    fmt.Printf("%s %s -> %.0f\n", str, char, float64(frequency[ rune(char[0]) ]*100)/float64( len(str) ) )
}

func main() {
    str := "perl"
    char := "e"
    percentage(str, char)

    str = "java"
    char = "a"
    percentage(str, char)

    str = "python"
    char = "m"
    percentage(str, char)

    str = "ada"
    char = "a"
    percentage(str, char);

    str = "ballerina"
    char = "l"
    percentage(str, char);

    str = "analitik"
    char = "k";
    percentage(str, char);
}

