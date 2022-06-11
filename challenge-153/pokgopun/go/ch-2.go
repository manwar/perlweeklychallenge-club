package main

import (
	"fmt"
	"log"
	"os"
	"strconv"
)

func main() {
	s := getArgInts([]int{145, 123})
	getF := getFactorial()
	for _, v := range s {
		//fmt.Println("Input: $n =", v)
		fmt.Printf("Input: $n = %d, ", v)
		f := 0
		n := v
		for {
			r, q := n%10, n/10
			if r == 0 && q == 0 {
				break
			}
			//f += factorial(r)
			f += getF(r)
			n = q
		}
		o := 0
		if f == v {
			o = 1
		}
		//fmt.Println("Output:", o)
		fmt.Printf("Output: %d\n", o)
	}
}
func getArgInts(s []int) (r []int) {
	if len(os.Args) > 1 {
		for _, v := range os.Args[1:] {
			i, err := strconv.Atoi(v)
			if err != nil {
				log.Fatal(err)
			}
			r = append(r, i)
		}
	} else {
		r = s
	}
	return r
}
func getFactorial() func(i int) int {
	m := map[int]int{}
	return func(i int) int {
		r, ok := m[i]
		if ok {
			return r
		}
		f := factorial(i)
		m[i] = f
		return f
	}
}
func factorial(n int) int {
	//fmt.Println("find f for", n)
	r := 1
	if n == 0 {
		return r
	}
	for i := 1; i <= n; i++ {
		r *= i
	}
	return r
}
