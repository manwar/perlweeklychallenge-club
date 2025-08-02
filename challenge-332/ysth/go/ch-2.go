package main

import (
    "fmt"
	"os"
)

func odd_letters(s string) bool {
    rune_odd := map[rune]int{} 
    for _, r := range []rune(s) {
        rune_odd[r] = 1 - rune_odd[r]
    }
    var evens bool
    for _, odd:= range rune_odd {
        if odd == 0 {
            evens = true
        }
    }
    return ! evens
}

func main() {
	for _, string := range os.Args[1:] {
        fmt.Printf("%-30s -> %t\n", string, odd_letters(string))
	}
}
