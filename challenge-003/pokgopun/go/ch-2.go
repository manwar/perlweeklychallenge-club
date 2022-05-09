package main

import (
	"fmt"
	"os"
	"strconv"
)

func main() {
	n := 5
	if len(os.Args) > 1 {
		r, err := strconv.Atoi(os.Args[1])
		if err == nil {
			n = r
		}
	}
	i := 1
	j := []int{1}
	for {
		fmt.Printf("%[1]*v", n-i, "")
		fmt.Println(j)
		if i >= n {
			break
		}
		i++
		if i > 1 {
			s := []int{}
			s = append(s, 1)
			for k := 1; k < i-1; k++ {
				s = append(s, j[k-1]+j[k])
			}
			s = append(s, 1)
			j = s
		}
	}
}
