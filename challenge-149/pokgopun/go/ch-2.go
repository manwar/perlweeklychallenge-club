package main

import (
	"fmt"
	"log"
	"math"
	"os"
	"sort"
	"strconv"
	"strings"
)

func main() {
	var base []int
	if len(os.Args) > 1 {
		base = argInts()
	} else {
		base = []int{2, 4, 10, 12}
	}
	for _, b := range base {
		var str string
		for i := b - 1; i >= 0; i-- {
			str += strconv.FormatInt(int64(i), b)
		}
		max, err := strconv.ParseUint(str, b, 64)
		//fmt.Println("max non-repeated number in base", b, "is", str, "=>", max)
		if err != nil {
			log.Fatal(err)
		}
		maxSqrt := uint64(math.Ceil(math.Sqrt(float64(max))))
		for i := maxSqrt; i > 0; i-- {
			str := strconv.FormatUint(i*i, b)
			if charIsUnique(str) {
				fmt.Printf("f(%v)=\"%v\"\n", b, strings.ToUpper(str))
				break
			}
		}
	}
}

func charIsUnique(str string) bool {
	var seen byte
	s := []byte(str)
	sort.SliceStable(s, func(i, j int) bool {
		return s[i] > s[j]
	})
	for i := 0; i < len(s); i++ {
		if s[i] == seen {
			return false
		}
		seen = s[i]
	}
	return true
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
