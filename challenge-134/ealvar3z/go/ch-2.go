package main

import (
	"fmt"
	"log"
	"sort"

	"github.com/ealvar3z/pwc"
)

func main() {
	for {
		var i, j int
		k, err := fmt.Scanf("%d %d", &i, &j)
		if k != 2 || err != nil {
			log.Println(err)
		}

		count := 0
		seen := map[int]bool{}
		for p := 1; p <= i; p++ {
			for q := 1; q <= j; q++ {
				if _, ok := seen[p*q]; !ok {
					count++
					seen[p*q] = true
				}
			}
		}

		//now let's create & sort an array with our map keys
		distincts := make([]int, 0, len(seen))
		for k := range seen {
			distincts = append(distincts, k)
		}
		sort.Ints(distincts)

		fmt.Printf("The count is %d\n", count)
		fmt.Printf("The distinct values are: %d\n", distincts)
		pwc.PrintTable(distincts, i, j, false)
	}
}
