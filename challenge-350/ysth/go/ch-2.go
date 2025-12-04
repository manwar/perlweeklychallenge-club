package main

// https://theweeklychallenge.org/blog/perl-weekly-challenge-350/#TASK2

import (
    "math"
    "slices"
    "strconv"
    run "github.com/ysth/runweeklychallenge-go"
)

// ShufflePairs
// from/to: range of integers
// count: number of shuffle pairs
//
// Shuffle pairs are two numbers whose digits when sorted yield the same string and having one a multiple of the other by a factor called the witness.
//
// Returns number of integers in the range that belong to at least the specified number of shuffle pairs

func ShufflePairs(from int, to int, count int) (int) {

    qualifyingIntegers := 0
    I:
    for i := from; i <= to; i++ {
        pairs := 0

        runes := []rune(strconv.Itoa(i))
        firstDigit := runes[0]
        slices.Sort(runes)
        sorted := string(runes)

        // look for possible pairs with a higher number
        // maximum higher number can't have more digits
        for witness, maxWitness := 2, (int(math.Pow10(len(runes))) - 1) / i; witness <= maxWitness; witness++ {
            j := []rune(strconv.Itoa(i * witness))
            slices.Sort(j)
            if string(j) == sorted {
                pairs++
                if pairs == count {
                    qualifyingIntegers++
                    continue I
                }
            }
        }
        // look for possible pairs with a lower number
        // maximum witness can't be more than i's first digit
        for witness, maxWitness := 2, int(firstDigit - '0'); witness <= maxWitness; witness++ {
            // if it doesn't divide evenly, i is not a multiple
            if i % witness != 0 {
                continue
            }
            j := []rune(strconv.Itoa(i / witness))
            slices.Sort(j)
            if string(j) == sorted {
                pairs++
                if pairs == count {
                    qualifyingIntegers++
                    continue I
                }
            }
        }
    }

    return qualifyingIntegers
}

func main() {
    run.RunWeeklyChallenge(
        func(inputs any) (string, error) { return strconv.Itoa(ShufflePairs(run.AsInt(inputs,"from"),run.AsInt(inputs,"to"),run.AsInt(inputs,"count"))), nil },
        `{"from":1,"to":1000,"count":1}`,
        `{
            "type": "object",
            "properties": {
                "from": {"type": "integer", "minimum": 0},
                "to": {"type": "integer", "minimum": 0},
                "count": {"type": "integer"}
            },
            "required": ["from", "to", "count"],
            "additionalProperties": false
        }`,
    )
}
