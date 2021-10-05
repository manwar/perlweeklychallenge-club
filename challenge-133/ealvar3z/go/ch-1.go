package main

import "fmt"

func intsqrt(n int) int {
	i := n >> 1
	if i != 0 {
		j := (i + n/i) >> 1
		for j < i {
			i = j
			j = (i + n/i) >> 1
		}
		return i
	}
	return n
}

func main() {
	y := intsqrt(10)
	z := intsqrt(27)
	x := intsqrt(85)
	r := intsqrt(101)

	fmt.Println(y)
	fmt.Println(z)
	fmt.Println(x)
	fmt.Println(r)
}
