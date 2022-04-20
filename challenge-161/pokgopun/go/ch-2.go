package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"sort"
	"strings"
)

type byteSeen map[byte]struct{}

func (bs byteSeen) countUnseen(s string) (n int) {
	b := []byte(s)
	sort.Slice(b, func(i, j int) bool {
		return b[i] < b[j]
	})
	var seen byte
	for _, v := range b {
		if seen == v {
			continue
		} else {
			seen = v
		}
		_, ok := bs[v]
		if !ok {
			n++
		}
	}
	return n
}
func main() {
	f, err := os.Open("../../../data/dictionary.txt")
	if err != nil {
		log.Fatal(err)
	}
	defer f.Close()
	pngrm := []string{}
	letters := byteSeen{}
	var best string
	scanner := bufio.NewScanner(f)
	for scanner.Scan() {
		if len(best) == 0 {
			best = "a"
		}
		b := scanner.Text()
		if b[:1] == best[:1] {
			if letters.countUnseen(best) >= letters.countUnseen(b) {
				continue
			}
			best = b
			continue
		}
		b, best = best, b
		//fmt.Println("b=", b, "best=", best)
		for _, v := range []byte(b) {
			letters[v] = struct{}{}
		}
		pngrm = append(pngrm, b)
		//fmt.Println(len(letters), len(pngrm))
		if len(letters) == 26 {
			break
		}
	}
	if err := scanner.Err(); err != nil {
		fmt.Fprintln(os.Stderr, "reading standard input:", err)
	}
	fmt.Println(pngrm)
	fmt.Printf("=> %d words, %d letters and %d unique letters\n", len(pngrm), len(strings.Join(pngrm, "")), len(letters))
}
