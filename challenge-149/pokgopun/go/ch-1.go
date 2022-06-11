package main

import (
	"fmt"
	"log"
	"os"
	"strconv"
)

func main() {
	var n int
	if len(os.Args) > 1 {
		i, err := strconv.ParseUint(os.Args[1], 10, 32)
		if err != nil {
			log.Fatal(err)
		}
		n = int(i)
	} else {
		n = 20
	}
	fds := make([]int, n)
	i := 0
	//isFib, t := makeIsFib()
	isFib, _ := makeIsFib()
	for j := 0; i < n; j++ {
		var sum int
		if j < 10 {
			sum = j
		} else {
			for _, v := range []byte(strconv.Itoa(j)) {
				k, err := strconv.Atoi(string(v))
				if err != nil {
					log.Fatal(err)
				}
				sum += k
			}
		}
		if isFib(sum) {
			fds[i] = j
			i++
		}
	}
	fmt.Println(fds)
	//t()
}

func makeIsFib() (func(int) bool, func()) {
	m := map[int]bool{
		0: true,
		1: true,
	}
	a, b := 1, 1
	return func(n int) bool {
			for b < n {
				a, b = b, b+a
				m[b] = true
			}
			return m[n]

		}, func() {
			fmt.Println(m)
		}
}
