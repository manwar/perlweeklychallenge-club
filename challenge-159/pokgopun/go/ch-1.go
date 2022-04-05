package main

import (
	"fmt"
	"log"
	"os"
	"strconv"
)

func main() {
	s := argInts()
	if len(s) == 0 {
		s = []int{5, 7, 4}
	}
	for _, n := range s {
		fmt.Println("Input: $n =", n)
		a, b, c, d := 0, 1, 1, n
		fmt.Printf("Output: %d/%d, %d/%d", a, b, c, d)
		if n > 1 {
			for {
				k := (n + b) / d
				a, b, c, d = c, d, k*c-a, k*d-b
				fmt.Printf(", %d/%d", c, d)
				if c == 1 && d == 1 {
					break
				}
			}
		}
		fmt.Printf("\n\n")
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
