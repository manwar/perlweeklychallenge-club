package main

import (
	"fmt"
	"os"
	"strconv"
)

func NSwap(n int) int {
	bin := fmt.Sprintf("%08b", n)

	a := bin[0:4]
	b := bin[4:8]

	c := b + a

	d, _ := strconv.ParseInt(c, 2, 64)
	return int(d)
}

func main() {
	n, _ := strconv.Atoi(os.Args[1])
	fmt.Println("Input:  $N = " + os.Args[1])
	fmt.Print("Outut: ")
	fmt.Println(NSwap(n))
}
