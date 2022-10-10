package main

import (
	"fmt"
	"os"
	"regexp"
	"strings"
)

func main() {
	if len(os.Args) < 2 {
		os.Args = append(os.Args, "1ac2.34f0.b1c2", "abc1.20f1.345a")
	}
	for _, v := range os.Args[1:] {
		fmt.Printf("Input: %s\nOutput: ", v)
		if o, ok := Convert(v); ok {
			fmt.Printf("%s\n\n", o)
		} else {
			fmt.Printf("invalid input\n\n")
		}
	}
}

func IsValid(s string) bool {
	return regexp.MustCompile(`^[a-f0-9]{4}\.[a-f0-9]{4}\.[a-f0-9]{4}$`).MatchString(s)
}

func Convert(s string) (string, bool) {
	if IsValid(s) {
		var b strings.Builder
		/*
			for _, bb := range regexp.MustCompile(`[a-z0-9]{2}`).FindAllString(s, -1) {
				b.WriteString(":" + bb)
			}
			return b.String()[1:], true
		*/
		for _, v := range strings.Split(s, ".") {
			b.WriteString(":" + v[0:2] + ":" + v[2:4])
		}
		return b.String()[1:], true

	}
	return "", false
}
