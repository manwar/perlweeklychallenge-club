/*
TASK #2 › Sleep Sort
Submitted by: Adam Russell
Another joke sort similar to JortSort suggested by champion Adam Russell.

You are given a list of numbers.

Write a script to implement Sleep Sort. For more information, please checkout this post.
*/
package main

import (
	"fmt"
	"log"
	"os"
	"sort"
	"strconv"
	"time"

	"github.com/google/go-cmp/cmp"
	"github.com/pokgopun/go/sleepsort"
)

func main() {
	sos := [][]uint{
		[]uint{3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5, 9},
		[]uint{2, 7, 1, 8, 2, 8, 1, 8, 2, 8, 4, 5, 9},
	}
	if len(os.Args) > 1 {
		sos = [][]uint{make([]uint, len(os.Args[1:]))}
		for i, v := range os.Args[1:] {
			n, err := strconv.ParseUint(v, 10, 64)
			if err != nil {
				log.Fatal(err)
			}
			sos[0][i] = uint(n)
		}
	}
	sor := make([][]uint, len(sos))
	copy(sor, sos)
	var res []uint
	durations := []time.Duration{time.Nanosecond, time.Microsecond, time.Millisecond}
	for i, s := range sos {
		fmt.Println("=> sleep sort", sor[i])
		sort.SliceStable(sor[i], func(m, n int) bool {
			return sor[i][m] < sor[i][n]
		})
		for _, d := range durations {
			fmt.Println("->", d)
			for j := 0; j < 3; j++ {
				res = sleepsort.Sort(s, d)
				fmt.Println("round", j+1, res, "ascending order:", cmp.Diff(sor[i], res) == "")
			}
		}
		fmt.Printf("\n")
	}
}
