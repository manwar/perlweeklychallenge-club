package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"sort"
)

func main() {
	f, err := os.Open("../../../data/dictionary.txt")
	if err != nil {
		log.Fatal(err)
	}
	defer f.Close()
	abc := []string{}
	scanner := bufio.NewScanner(f)
	for scanner.Scan() {
		s := scanner.Text()
		if isAbc(s) {
			abc = append(abc, s)
		}
	}
	if err := scanner.Err(); err != nil {
		fmt.Fprintln(os.Stderr, "reading standard input:", err)
	}
	sort.SliceStable(abc, func(i, j int) bool {
		return len(abc[i]) > len(abc[j])
	})
	fmt.Println(abc)
}
func isAbc(s string) bool {
	b := []byte(s)
	if len(b) > 1 {
		for i := 1; i < len(b); i++ {
			if b[i] < b[i-1] {
				return false
			}
		}
	}
	return true
}
