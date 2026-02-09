package main

import (
	"fmt"
)

func stringReduction(s string) string {
	var res []rune
	for _, c := range s {
		if len(res) > 0 && res[len(res)-1] == c {
			res = res[:len(res)-1]
		} else {
			res = append(res, c)
		}
	}
	return string(res)
}

func main() {
	fmt.Println(stringReduction("aabbccdd"))
	fmt.Println(stringReduction("abccba"))
	fmt.Println(stringReduction("abcdef"))
	fmt.Println(stringReduction("aabbaeaccdd"))
	fmt.Println(stringReduction("mississippi"))
}
