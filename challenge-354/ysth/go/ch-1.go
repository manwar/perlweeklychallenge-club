package main

// https://theweeklychallenge.org/blog/perl-weekly-challenge-354/#TASK1

import (
    "slices"
    run "github.com/ysth/runweeklychallenge-go"
)

// Given an array of distinct integers, return all pairs that have the minimum difference.
func MinAbsDiff(ints []int) [][]int {
    minDifferencePairs := [][]int{}
    if len(ints) > 0 {
        sortedInts := slices.Clone(ints)
        slices.Sort(sortedInts)

        minDifference := sortedInts[len(sortedInts)-1] - sortedInts[0]
        for index, value := range sortedInts {
            if index > 0 {
                difference := value - sortedInts[index-1]
                if difference <= minDifference {
                    if difference < minDifference {
                        minDifference = difference
                        minDifferencePairs = minDifferencePairs[:0]
                    }
                    minDifferencePairs = append(minDifferencePairs, []int{sortedInts[index-1], value})
                }
            }
        }
    }
    return minDifferencePairs
}

func main() {
    run.RunWeeklyChallenge(
        func(inputs any) (string, error) { return run.JSONEncode(MinAbsDiff(run.InputsAsIntSlice(inputs))), nil },
        `[4, 2, 1, 3]`,
        `{"type":"array", "items":{"type": "integer"}}`,
    )
}
