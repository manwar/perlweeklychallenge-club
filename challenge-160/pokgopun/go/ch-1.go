package main

import (
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
)

func main() {
	m := []string{"one", "two", "three", "four", "five", "six", "seven", "eight", "nine"}
	var num []int
	if len(os.Args) > 1 {
		num = argInts()
	} else {
		num = []int{5, 7, 6}
	}
	for _, n := range num {
		fmt.Println("Input: $n =", n)
		w := m[n-1]
		var str string
		for {
			if w == "four" {
				str += " is magic"
				break
			} else {
				w = m[len(w)-1]
				str += " is " + w + ", " + w
			}
		}
		fmt.Print("Output: " + strings.Title(m[n-1]) + str + ".\n\n")
	}
}
func argInts() (s []int) {
	if len(os.Args) > 1 {
		for _, v := range os.Args[1:] {
			i, err := strconv.Atoi(v)
			if err != nil {
				log.Fatal(err)
			}
			s = append(s, i)
		}
	}
	return s
}
