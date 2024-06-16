package main

import (
	"fmt"
)

func percentageOfCharacter(str string, c rune) int {
	count := 0
	for _,v := range str {
		if v == c {
			count++
		}
	}
	return int(float32(count) / float32(len(str)) * 100.0 + float32(0.5))
}

func main() {
	fmt.Println(percentageOfCharacter("perl", 'e'))
	fmt.Println(percentageOfCharacter("java", 'a'))
	fmt.Println(percentageOfCharacter("python", 'm'))
	fmt.Println(percentageOfCharacter("ada", 'a'))
	fmt.Println(percentageOfCharacter("ballerina", 'l'))
	fmt.Println(percentageOfCharacter("analitik", 'k'))
}
