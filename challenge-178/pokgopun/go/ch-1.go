package main

import (
	"fmt"
	"sort"
	"strconv"
)

func main() {
	for i := 1; i >= -1; i -= 2 {
		for j := 1; j <= 16; j++ {
			n := i * j
			var res string
			qi := toQI(n, &res)
			fmt.Printf("toQI(%v) = %v, fromQI(%[2]v) = %v\n", n, qi, fromQI(qi))
		}
	}
}

func fromQI(qi string) int {
	b := []byte(qi)
	sort.SliceStable(b, func(i, j int) bool {
		return true
	})
	var sum int
	ii := 1
	for i := 0; i < len(b); i += 2 {
		sum += int(b[i]-48) * ii
		ii *= -4
	}
	return sum
}
func toQI(n int, res *string) string {
	if n > 0 {
		*res += strconv.Itoa(n%4) + "0"
		toQI(-1*(n/4), res)
	} else if n < 0 {
		i := 1
		for -4*i > n {
			i++
		}
		*res += strconv.Itoa(4*i+n) + "0"
		toQI(i, res)
	}
	if *res == "" {
		return "0"
	}
	b := []byte(*res)
	sort.SliceStable(b, func(i, j int) bool {
		return true
	})
	return string(b[1:])
}
