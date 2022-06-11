package main

import (
	"encoding/json"
	"fmt"
	"io"
	"log"
	"os"
	"sort"
	"strings"
)

func main() {
	var jsonStream string
	if len(os.Args) > 1 {
		for _, v := range os.Args[1:] {
			jsonStream += fmt.Sprintf("%v\n", v)
		}
	} else {
		jsonStream = `
[ [1], [5,3], [2,3,4], [7,1,0,2], [6,4,5,2,8] ]
[ [5], [2,3], [4,1,5], [0,1,2,3], [7,2,4,1,9] ]
`
	}
	dec := json.NewDecoder(strings.NewReader(jsonStream))
	for {
		var sos [][]int
		if err := dec.Decode(&sos); err == io.EOF {
			break
		} else if err != nil {
			log.Fatal(err)
		}
		fmt.Println("Input: $triangle =", sos)
		fmt.Println("Output:", sumMin(sos))
	}
	//	sos := [][]int{
	//		[]int{1},
	//		[]int{2, 3},
	//		[]int{4, 5, 6},
	//		[]int{7, 8, 9, 10},
	//		[]int{11, 12, 13, 14, 15},
	//	}
	//	fmt.Println(sos)
}

func sumMin(s [][]int) (sum int) {
	for _, v := range s {
		sort.Slice(v, func(i, j int) bool {
			return v[i] < v[j]
		})
		sum += v[0]
	}
	return sum
}
