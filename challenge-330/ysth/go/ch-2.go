package main

import (
    "fmt"
    "os"
    "strings"
    "slices"
    "github.com/clipperhouse/uax29/graphemes"
)

func grapheme_length_more_than_2(word string) bool {
    var seg = graphemes.NewSegmenter([]byte(word))
    return seg.Next() && seg.Next() && seg.Next() && true
}

func title_capital(in string) string {
    return strings.Join(
        slices.Collect(func(yield func(string) bool) {
            for _, word := range strings.Split(in, " ") {
                var cased_word string
                if grapheme_length_more_than_2(word) {
                    runes := []rune(word)
                    cased_word = strings.ToTitle(string(runes[0])) + strings.ToLower(string(runes[1:]))
                } else {
                    cased_word = strings.ToLower(word)
                }
                if !yield(cased_word) {
                    return
                }
            }
        }), " ")
}

func main() {
    for _, string := range os.Args[1:] {
        fmt.Printf("%-30s -> %s\n", string, title_capital(string))
    }
}
