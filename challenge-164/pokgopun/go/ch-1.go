package main

import (
	"fmt"
	"math"
	"os"
	"strconv"
)

func main() {
	n := 1000
	if len(os.Args) > 1 {
		r, err := strconv.Atoi(os.Args[1])
		if err == nil {
			if r <= 10_000_000 {
				n = r
			} else {
				n = 10_000_000
			}
		}
	}
	n--
	fmt.Println(ppld(n))
}
func ppld(n int) (r []int) {
	m := make([]bool, n+2)
	for i := 2; i <= n; i++ {
		s := strconv.Itoa(i)
		l := len(s)
		for i := 0; i < l/2; i++ {
			if s[i] != s[l-1-i] {
				goto done
			}
		}
		m[i] = true
	done:
	}
	for i := 2; float64(i) <= math.Sqrt(float64(n)); i++ {
		j := i * i
		for j <= n {
			m[j] = false
			j += i
		}

	}
	for k := 2; k <= n; k++ {
		if m[k] {
			r = append(r, k)
		}
	}
	return r
}
