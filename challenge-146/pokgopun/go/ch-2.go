package main

import (
	"fmt"
	"os"
)

func main() {
	var sample []string
	if len(os.Args) > 1 {
		sample = os.Args[1:]
	} else {
		sample = []string{
			"redivider",
			"deific",
			"rotors",
			"challenge",
			"champion",
			"christmas",
		}
	}
	fmt.Println(sample)
}
