/*
Task 1: Kill and Win
Submitted by: Mohammad S Anwar

You are given a list of integers.
Write a script to get the maximum points. You are allowed to take out (kill) any integer and remove from the list. However if you do that then all integers exactly one-less or one-more would also be removed. Find out the total of integers removed.

Example 1
Input: @int = (2, 3, 1)
Output: 6

First we delete 2 and that would also delete 1 and 3. So the maximum points we get is 6.

Example 2
Input: @int = (1, 1, 2, 2, 2, 3)
Output: 11

First we delete 2 and that would also delete both the 1's and the 3. Now we have (2, 2).
Then we delete another 2 and followed by the third deletion of 2. So the maximum points we get is 11.
*/

package main

import (
    "fmt"
    "log"
    "os"
    "strconv"
)

func main() {
    arrStr := os.Args[1:]
    if (len(arrStr) < 1) {
        log.Fatal("input error")
    }

    var tot int = 0
    for i := 0; i <= len(arrStr)-1; i++ {
        value, err := strconv.Atoi(arrStr[i])
        if (err != nil) {
            log.Fatal(err)
        }
        tot += value
    }

    fmt.Printf("Output: %d\n",tot)
}
