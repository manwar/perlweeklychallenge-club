package main

import (
	"fmt"
	"log"
	"os"
	"strconv"
)

func main() {
	const debug = false
	sos := [][]int{argInts()}
	if len(sos[0]) == 0 {
		sos = [][]int{
			[]int{2, 4, 5},
			[]int{4, 2, 3, 6, 5, 3},
		}
	}
	for _, s := range sos {
		fmt.Println("Input: @valuables =", s)
		ch := make(chan []int)
		go func() {
			rob([]int{s[0]}, s[1:], ch)
			close(ch)
		}()
		var max int
		var rob []int
		for r := range ch {
			//fmt.Println(r)
			a := sum(r)
			if a > max {
				max = a
				rob = r
			}
		}
		if debug {
			fmt.Println(rob)
		}
		fmt.Printf("Output: %d\n\n", max)
	}
}
func rob(c []int, e []int, ch chan<- []int) {
	if len(e) < 2 {
		//fmt.Println("=>", c)
		s := make([]int, len(c))
		copy(s, c)
		ch <- s
	} else {
		for i := 1; i <= 2; i++ {
			if len(e[i:]) < 1 {
				break
			}
			rob(append(c, e[i]), e[i+1:], ch)
		}
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

func sum(s []int) (r int) {
	for _, v := range s {
		r += v
	}
	return r
}
