package main

import (
	"fmt"
)

func textJustifier(str string, width int) string {
	bs := make([]byte, width)
	j := (width - len(str)) / 2
	l := copy(bs[j:], []byte(str))
	i := j + l
	for width > i {
		width--
		bs[width] = '*'
	}
	for j > 0 {
		j--
		bs[j] = '*'
	}
	return string(bs)
}

func main() {
	fmt.Println(textJustifier("Hi", 5))
	fmt.Println(textJustifier("Code", 10))
	fmt.Println(textJustifier("Hello", 9))
	fmt.Println(textJustifier("Perl", 4))
	fmt.Println(textJustifier("A", 7))
	fmt.Println(textJustifier("", 5))
}
