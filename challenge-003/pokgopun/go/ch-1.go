package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func main() {
	var n uint = 62
	if len(os.Args) > 1 {
		r, err := strconv.ParseUint(os.Args[1], 10, 64)
		if err == nil {
			n = uint(r)
		}
	}
	m := make(map[uint]bool, 3)
	var i, j uint = 1, 1
	w := bufio.NewWriter(os.Stdout)
	fmt.Fprint(w, 1)
	for {
		if j >= n {
			break
		}
		for _, v := range []uint{2 * i, 3 * i, 5 * i} {
			m[v] = true
		}
		i = 2 * i
		for k, _ := range m {
			if k < i {
				i = k
			}
		}
		fmt.Fprint(w, ", ", i)
		j++
		delete(m, i)
	}
	fmt.Fprint(w, "\n")
	w.Flush()
}
