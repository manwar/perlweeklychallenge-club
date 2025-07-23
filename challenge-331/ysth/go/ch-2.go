package main

import (
    "fmt"
    "os"
)

func buddy_strings(string1 string, string2 string) bool {
    if (string1 == string2) { return false }
    var runes1 = []rune(string1)
    var runes2 = []rune(string2)
    if len(runes1) != len(runes2) { return false }
    var differences int = 0
    for i := range runes1 {
        if runes1[i] != runes2[i] {
            differences++
            if differences > 1 { return false }
        }
    }
    return true 
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
