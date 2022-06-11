package main

import (
	"fmt"
	"log"
	"os"
	"strconv"
)

func main() {
	i := getArgInt(12)
	d := getDivisors(i)
	sum := 0
	for _, v := range d {
		sum += v
	}
	var o int
	ds := []int{}
	var sums int
	if sum > i {
		o = 1
		for j := 2; j < len(d); j++ {
			sos := getCombo(j, d)
			for _, s := range sos {
				var sum int
				for _, v := range s {
					sum += v
				}
				if sum == i {
					o = 0
					ds = s
					sums = sum
					goto done
				}
			}
		}
	}
done:
	fmt.Println("Input: $n =", i)
	msg := fmt.Sprint("The proper divisors ", d, " sum to ", sum, " which is ")
	if sum > i {
		fmt.Print(msg, "greater than $n")
	} else {
		fmt.Print(msg, "less than $n\n")
	}
	if sums != 0 {
		fmt.Println(", but its subset", ds, "sums to", sums)
	} else if o == 1 {
		fmt.Println(" and none of its subset sums to", i)
	}
	fmt.Println("Output:", o)
}
func getArgInt(n int) int {
	if len(os.Args) > 1 {
		u, err := strconv.ParseUint(os.Args[1], 10, 64)
		if err != nil {
			log.Fatal(err)
		}
		n = int(u)
	}
	return n
}
func getDivisors(n int) (d []int) {
	for i := 1; i <= n/2; i++ {
		if n%i == 0 {
			d = append(d, i)
		}
	}
	return d
}
func getCombo(n int, e []int) (r [][]int) {
	c := []int{}
	cTree(n, e, c, func(s []int) {
		r = append(r, s)
	})
	return r
}
func cTree(n int, e []int, c []int, f func(s []int)) {
	if len(c) == n || len(c)+len(e) == n {
		s := append(c, e...)
		f(s[:n])
	} else {
		for i := 0; len(c)+len(e)-i >= n; i++ {
			cTree(n, e[i+1:], append(c, e[i]), f)
		}
	}
}
