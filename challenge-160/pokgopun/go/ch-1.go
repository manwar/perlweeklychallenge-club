package main

import (
	"fmt"
	"log"
	"os"
	"regexp"
	"strconv"
	"strings"
)

func main() {
	m := map[int]string{
		1: "one",
		2: "two",
		3: "three",
		4: "four",
		5: "five",
		6: "six",
		7: "seven",
		8: "eight",
		9: "nine",
	}
	//fmt.Println(m)
	re := regexp.MustCompile(`\S+$`)
	var num []int
	if len(os.Args) > 1 {
		num = argInts()
	} else {
		num = []int{5, 7, 6}
	}
	for _, n := range num {
		fmt.Println("Input: $n =", n)
		str := m[n]
		for {
			r := re.FindString(str)
			if r == "four" {
				str += " is magic"
				break
			} else {
				nxt := m[len(r)]
				str += " is " + nxt + ", " + nxt
				r = str

			}
		}
		fmt.Printf("Output: %v.\n\n", strings.Title(str[:1])+str[1:])
	}
}
func argInts() (s []int) {
	if len(os.Args) > 1 {
		for _, v := range os.Args[1:] {
			i, err := strconv.Atoi(v)
			if err != nil {
				log.Fatal(err)
			}
			s = append(s, i)
		}
	}
	return s
}
