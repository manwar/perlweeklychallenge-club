package main

import (
    "fmt"
    "os"
)

func buddy_strings(string1 string, string2 string) bool {
    var runes1 = []rune(string1)
    var runes2 = []rune(string2)
    if len(runes1) != len(runes2) { return false }
    var swaps int = 0
    var pair_exists bool = false
    var previous_character1 rune
    var previous_character2 rune
    for i := range runes1 {
        var character1 rune = runes1[i]
        var character2 rune = runes2[i]
        if swaps == 1 {
            // second character of swap
            if previous_character2 != character1 || character2 != previous_character1 {
                return false
            }
            swaps = 2
        } else if character1 != character2 {
            // starting the first swap
            if swaps > 0 { return false }
            previous_character1 = character1
            previous_character2 = character2
            swaps = 1
        }
        pair_exists = pair_exists || i > 0 && runes1[i-1] == runes1[i]
    }

    return swaps == 0 && pair_exists || swaps == 2
}

func main() {
    var inputs = os.Args[1:]
    for arg := 0; arg < len(inputs) - 1; arg += 2 {
        var buddies string
        if buddy_strings(inputs[arg], inputs[arg+1]) {
            buddies = "yes"
        } else {
            buddies = "no"
        }
        fmt.Printf("%-30s\n%-30s\n    -> %s\n", inputs[arg], inputs[arg+1], buddies)
    }
}
