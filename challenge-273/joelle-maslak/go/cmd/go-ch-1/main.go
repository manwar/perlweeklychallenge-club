package main

import (
	"fmt"
	"os"
	"strings"
)

func main() {
	if len(os.Args) != 3 || len(os.Args[1]) < 1 || len(os.Args[2]) != 1 {
		usage()
		return
	}

	strlen := float32(len(os.Args[1]))
	cnt := float32(strings.Count(os.Args[1], os.Args[2]))
	fmt.Printf("Percentage of times character appears in string: %.0f%%\n", 100.0*cnt/strlen)
}

func usage() {
	fmt.Fprintln(os.Stderr, "Usage:")
	fmt.Fprintln(os.Stderr, "")
	fmt.Fprintln(os.Stderr, "Calculates the percentage of characters in a string match a given character")
	fmt.Fprintln(os.Stderr, "")
	fmt.Fprintln(os.Stderr, "  "+os.Args[0]+" <str> <char>")
	fmt.Fprintln(os.Stderr, "")
}
