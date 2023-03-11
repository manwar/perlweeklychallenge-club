/*
Task 1: Keyboard Word
Submitted by: Mohammad S Anwar

You are given an array of words.
Write a script to print all the words in the given array that can be types using alphabet on only one row of the keyboard.

Let us assume the keys are arranged as below:
Row 1: qwertyuiop
Row 2: asdfghjkl
Row 3: zxcvbnm

Example 1
Input: @words = ("Hello","Alaska","Dad","Peace")
Output: ("Alaska","Dad")

Example 2
Input: @array = ("OMG","Bye")
Output: ()
*/

package main

import (
    "fmt"
    "os"
    "regexp"
    "strings"
)

func main() {
    arrStr := os.Args[1:]

    aclass := [3]string{"qwertyuiop","asdfghjkl","zxcvbnm"}
    output := make([]string, 0)
    for i := 0; i <= len(arrStr)-1; i++ {
        word := arrStr[i]
        for j := 0; j <= len(aclass)-1; j++ {
            match, err := regexp.MatchString(`^[`+aclass[j]+`]+$`, strings.ToLower(word))
            if err == nil {
                if match {
                    output = append(output, word)
                    break
                }
            } else {
                fmt.Println("Error:", err)
            }
        }
    }
    fmt.Println(output)
}
