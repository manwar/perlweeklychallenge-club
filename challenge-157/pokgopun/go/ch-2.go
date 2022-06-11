package main

import (
	"fmt"
	"log"
	"os"
	"strconv"
)

func main() {
	s := getArgInts([]int{7, 6, 8})
	for _, v := range s {
		fmt.Printf("Input: $n = %d", v)
		var o int
		for b := 2; b < v-1; b++ {
			n := v
			//var digits []int
			m := map[int]bool{}
			for {
				r := n % b
				m[r] = true
				//digits = append(digits, r)
				if n = n / b; n == 0 {
					break
				}
			}
			if len(m) == 1 {
				o = 1
				/*
					sort.SliceStable(digits, func(i, j int) bool {
						return true
					})
					fmt.Printf(", Since %d in base %d is %v", v, b, digits)
				*/
				break
			}
		}
		//fmt.Printf(", Output: %d\n\n", o)
		fmt.Printf("\nOutput: %d\n\n", o)
	}
}
func getArgInts(s []int) (r []int) {
	if len(os.Args) > 1 {
		for _, v := range os.Args[1:] {
			i, err := strconv.Atoi(v)
			if err != nil {
				log.Fatal(err)
			}
			if i < 4 {
				log.Fatal("Input must be an integer greater than 3")
			}
			r = append(r, i)
		}
	} else {
		r = s
	}
	return r
}
