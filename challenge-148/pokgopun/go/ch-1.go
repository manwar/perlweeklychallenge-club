package main

import (
	"fmt"
	"regexp"

	"github.com/divan/num2words"
)

func main() {
	eban := []int{}
	re := regexp.MustCompile(`[eE]`)
	for i := 1; i <= 100; i++ {
		if !re.MatchString(num2words.Convert(i)) {
			eban = append(eban, i)
		}
	}
	fmt.Println(eban)
}
