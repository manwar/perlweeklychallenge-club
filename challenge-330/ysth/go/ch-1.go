package main

import (
    "fmt"
	"os"
    "github.com/htfy96/go-pcre2/v2"
)
var subst = pcre2.MustCompile("[0-9]+|(?<pair>[a-z](?&pair)?[0-9])+", 0)

func clear_digits(in string) string {
    out := subst.ReplaceAllString(in, "", 0)
    return out
}

func main() {
	for _, string := range os.Args[1:] {
        fmt.Printf("%-30s -> %s\n", string, clear_digits(string))
	}
}
