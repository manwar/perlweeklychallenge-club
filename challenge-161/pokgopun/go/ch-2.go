package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
)

type bools []bool

func (b *bools) allTrue() bool {
	for i := 0; i < len(*b); i++ {
		if !(*b)[i] {
			return false
		}
	}
	return true
}
func (b *bools) newTruth(bs bools) int {
	return 0
}
func main() {
	f, err := os.Open("../../../data/dictionary.txt")
	if err != nil {
		log.Fatal(err)
	}
	defer f.Close()
	pngrm := []string{}
	seen := make(bools, 26)
	scanner := bufio.NewScanner(f)
	for scanner.Scan() {
		for _, v := range scanner.Bytes() {
			v -= 97
			seen[v] = true
		}
		pngrm = append(pngrm, scanner.Text())
		if seen.allTrue() {
			break
		}
	}
	if err := scanner.Err(); err != nil {
		fmt.Fprintln(os.Stderr, "reading standard input:", err)
	}
	fmt.Println(pngrm, len(pngrm))
}
