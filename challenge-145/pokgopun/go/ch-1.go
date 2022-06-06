// You are given 2 arrays of same size, @a and @b.
// Write a script to implement Dot Product.
// Usage: go run ch-1.go 1,2,3 4,5,6
package main

import (
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
)

func main() {
	var sample [][]int
	if len(os.Args) > 2 {
		m := map[int]struct{}{}
		for _, v := range os.Args[1:] {
			strs := strings.Split(v, ",")
			m[len(strs)] = struct{}{}
			nums := make([]int, len(strs))
			for i, v := range strs {
				n, err := strconv.Atoi(v)
				if err != nil {
					log.Fatal(err)
				}
				nums[i] = n
			}
			sample = append(sample, nums)
		}
		if len(m) > 1 {
			log.Fatal("Arrays are not in the same size")
		}
	} else {
		sample = [][]int{
			[]int{1, 2, 3},
			[]int{4, 5, 6},
		}
	}
	fmt.Println(sample, "=>", dp(sample))
}

func dp(ss [][]int) (r int) {
	l := len(ss[0])
	for i := 0; i < l; i++ {
		n := 1
		for j := 0; j < len(ss); j++ {
			n *= ss[j][i]
		}
		r += n
	}
	return r
}
