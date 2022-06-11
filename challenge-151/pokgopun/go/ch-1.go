package main

import (
	"fmt"
	"log"
	"math"
	"os"
	"regexp"
	"sort"
	"strconv"
	"strings"
)

func main() {
	samples := os.Args[1:]
	if len(samples) == 0 {
		samples = []string{
			"1 | 2 3 | 4 5",
			"1 | 2 3 | 4 * * 5 | * 6",
		}
	}
	re := regexp.MustCompile(`\S+`)
	for _, sample := range samples {
		fmt.Printf("Input: '%v'\n", sample)
		levels := strings.Split(sample, "|")
		nodes := make([]string, int(math.Pow(2, float64(len(levels)))))
		//fmt.Println(nodes)
		for i := len(levels) - 1; i >= 0; i-- {
			ns := make([]string, int(math.Pow(2, float64(i))))
			copy(ns, re.FindAllString(levels[i], -1))
			//fmt.Println(ns)
			for j := 0; j < len(ns); j++ {
				s := []int{}
				for _, v := range nodes[2*j : 2*j+2] {
					if v == "" || v == "*" {
						continue
					}
					n, err := strconv.Atoi(v)
					if err != nil {
						log.Fatal(err)
					}
					s = append(s, n)
				}
				//fmt.Println(" s =", s)
				if len(s) != 0 {
					sort.SliceStable(s, func(i, j int) bool {
						return s[i] < s[j]
					})
					ns[j] = strconv.Itoa(s[0])
				} else {
					if ns[j] == "*" || ns[j] == "" {
						ns[j] = "*"
					} else {
						ns[j] = strconv.Itoa(i + 1)
					}
				}
			}
			//fmt.Println("=>", ns)
			nodes = ns
		}
		fmt.Printf("Output: %v\n\n", nodes[0])
	}
}
