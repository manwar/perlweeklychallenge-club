/*
Task 2: Penny Piles
Submitted by: Robbie Hatley

You are given an integer, $n > 0.
Write a script to determine the number of ways of putting $n pennies in a row of piles of ascending heights from left to right.

Example
Input: $n = 5
Output: 7

Since $n=5, there are 7 ways of stacking 5 pennies in ascending piles:
    1 1 1 1 1
    1 1 1 2
    1 2 2
    1 1 3
    2 3
    1 4
    5
*/

package main

import (
    "fmt"
)

func main() {
    var totPenny int
    var maxPiles int
    var remainingPenny int
    //var piles = make([]int, 0)
    var piles [][]int

    fmt.Print("Please enter a integer number > 0: ")
    fmt.Scanf("%d", &totPenny)
    maxPiles = totPenny

    for currPiles := maxPiles; currPiles > 0; currPiles-- {
        seedData := make([]int, currPiles)
        for i := range seedData {
            seedData[i] = 1
        }
        remainingPenny = totPenny - sum(seedData)

        remainingCombinations := make([]int, remainingPenny+1)
        for i := range remainingCombinations {
            remainingCombinations[i] = i
        }
        results := permutations(remainingCombinations, len(seedData))
        for i := range results {
            if (sum(results[i]) != remainingPenny || (len(results[i]) > 0 && !checkAscendingOrder(results[i])) ) {
                continue
            }
            data := make([]int, len(seedData))
            for k := range seedData {
                data[k] = seedData[k] + results[i][k]
            }
            piles = append(piles, data)
        }
    }
    fmt.Printf("Since n=%d, there are %d ways of stacking %d pennies in ascending piles:", totPenny, len(piles), totPenny);
    for i:=0; i<=len(piles)-1; i++ {
        fmt.Printf("\n\t")
        for _, value := range piles[i] {
            fmt.Printf(" %d", value)
        }
    }
    fmt.Println()
}

func checkAscendingOrder(arr []int) bool {
    var sortedArray = true
    for i:=0; i<=len(arr)-2; i++ {
        if arr[i] > arr[i+1]{
            sortedArray = false
            break
         }
    }
    return sortedArray
}

func sum(array[] int) int {
    result := 0
    for _,
    v := range array {
        result += v
    }
    return result
}

func permutations(elements []int, length int) [][]int {
    var results [][]int
    var perm = make([]int, length)      // to write each permutation
    used := make([]bool, len(elements)) // used[i] indicates whether i-th element is already used
    var withRepetition = true

    var dfs func(currentIndex, depth int)
    dfs = func(currentIndex, depth int) {
        perm[length-depth] = elements[currentIndex]
        if depth == 1 {
            result := make([]int, length)
            copy(result, perm)
            results = append(results, result)
            return
        }
        used[currentIndex] = true
        for i := range elements {
            if !withRepetition && used[i] {
                continue
            }
            dfs(i, depth-1)
        }
        used[currentIndex] = false
    }
    // start from all elements
    for i := range elements {
        dfs(i, length)
    }
    return results
}
