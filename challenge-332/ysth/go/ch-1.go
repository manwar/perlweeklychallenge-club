package main

import (
    "fmt"
	"os"
    "slices"
    "strconv"
    "strings"
)

func binary_date(date string) string {
    return strings.Join(
        slices.Collect(func(yield func(string) bool) {
            for _, component := range strings.Split(date, "-") {
                component_as_int, err := strconv.Atoi(component)
                if err != nil {
                    panic(err)
                }
                var component_in_binary = fmt.Sprintf("%b", component_as_int)
                if !yield(component_in_binary) {
                    return
                }
            }
        }), "-")
}

func main() {
	for _, string := range os.Args[1:] {
        fmt.Printf("%-30s -> %s\n", string, binary_date(string))
	}
}
