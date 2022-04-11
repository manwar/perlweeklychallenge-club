package main

import (
	"fmt"
	"log"
	"os"
	"strconv"
)

func main() {
	var num [][]int
	if len(os.Args) > 3 {
		num = [][]int{argInts()}
	} else {
		num = [][]int{
			[]int{1, 3, 5, 7, 9},
			[]int{1, 2, 3, 4, 5},
			[]int{2, 4, 2},
		}
	}
	for _, n := range num {
		fmt.Println("Input: @n =", n)
		o := -1
		for i := 1; i < len(n)-1; i++ {
			if sum(n[:i]) == sum(n[i+1:]) {
				o = i
				break
			}
		}
		fmt.Printf("Output: %v\n\n", o)
	}
}
func sum(s []int) (r int) {
	for _, v := range s {
		r += v
	}
	return r
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
