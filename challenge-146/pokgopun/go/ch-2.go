package main

import (
	"fmt"
	"log"
	"os"
)

func main() {
	samples := [][2]uint{
		[2]uint{3, 5},
		[2]uint{4, 3},
	}
	if len(os.Args) > 1 {
		var sample [2]uint
		_, err := fmt.Sscanf(os.Args[1], "%d/%d", &sample[0], &sample[1])
		if err != nil {
			log.Fatal(err)
		}
		samples = [][2]uint{sample}
	}
	for _, v := range samples {
		p := parent(v)
		gp := parent(p)
		fmt.Printf("Input: member = '%d/%d'\nOutput: parent ='%d/%d' and grandparent = '%d/%d'\n", v[0], v[1], p[0], p[1], gp[0], gp[1])
	}
}

func parent(s [2]uint) [2]uint {
	if s[0] > s[1] {
		return [2]uint{s[0] - s[1], s[1]}
	} else if s[0] < s[1] {
		return [2]uint{s[0], s[1] - s[0]}
	}
	return [2]uint{1, 1}
}
