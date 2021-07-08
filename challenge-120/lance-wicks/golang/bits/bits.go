package main

import (
	"fmt"
	"os"
	"regexp"
	"strconv"
)

func main() {
	n, _ := strconv.Atoi(os.Args[1])
	fmt.Print("Output: ")
	fmt.Println(swapBits(n))
}

func swapBits(n int) int {
	binary := fmt.Sprintf("%08b", n)

	re := regexp.MustCompile(`..`)
	bits := re.FindAllString(binary, -1)
	binary_reversed := ""

	for _, bit := range bits {
		binary_reversed = binary_reversed + Reverse(bit)
	}

	new_int, _ := strconv.ParseInt(binary_reversed, 2, 64)

	return int(new_int)
}

func Reverse(s string) string {
	runes := []rune(s)
	for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
		runes[i], runes[j] = runes[j], runes[i]
	}
	return string(runes)
}
