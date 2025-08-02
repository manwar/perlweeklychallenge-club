package main

import (
    "fmt"
	"os"
    "regexp"
    "github.com/clipperhouse/uax29/graphemes"
)

func grapheme_length(word string) int {
    var grapheme_length int = 0
    var seg = graphemes.NewSegmenter([]byte(word))
    for seg.Next() {
        grapheme_length++
    }
    return grapheme_length
}

func last_match(r *regexp.Regexp, s string) string {
    var out string
    for offset, loc := 0, []int{0,0}; loc != nil; loc = r.FindStringIndex(s[offset:]) {
        out = s[offset+loc[0]:offset+loc[1]]
        offset += loc[1]
    }
    return out
}

var word = regexp.MustCompile(`[\p{L}\p{N}\p{M}\p{Pc}]+`)

func last_word_length(s string) int {
    return grapheme_length(last_match(word, s))
}

func main() {
	for _, string := range os.Args[1:] {
        fmt.Printf("%-30s -> %d\n", string, last_word_length(string))
	}
}
