package main

import (
	"fmt"
	"os"
)

func main() {
	a, b := "1234", "5678"
	if len(os.Args) > 2 {
		a, b = os.Args[1], os.Args[2]
	}
	fmt.Printf("Input: $a = '%v' $b = '%v'\n", a, b)
	for len([]rune(b)) < 51 {
		a, b = b, a+b
	}
	fmt.Println("Output:", string([]rune(b)[50]))
}
