package main

import (
	"bufio"
	"fmt"
	"io"
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
	dict := "../../../data/dictionary.txt"
	if len(os.Args) > 1 {
		dict = os.Args[1]
	}
	var r io.Reader
	f, err := os.Open(dict)
	if err != nil {
		//log.Fatal(err)
		s := `the
quick
brown
fox
jumps
over
the
lazy
dog
`
		r = strings.NewReader(s)
	} else {
		defer f.Close()
		r = f
	}
	pngrm := []string{}
	letters := byteSeen{}
	var best string
	scanner := bufio.NewScanner(r)
	for scanner.Scan() {
		b := scanner.Text()
		if len(best) == 0 {
			//best = "a"
			best = b[0:1]
		}
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
	if len(letters) < 26 {
		pngrm = append(pngrm, best)
		for _, v := range []byte(best) {
			letters[v] = struct{}{}
		}
	}
	if err := scanner.Err(); err != nil {
		fmt.Fprintln(os.Stderr, "reading standard input:", err)
	}
	if len(letters) == 26 {
		fmt.Println(pngrm)
		fmt.Printf("=> %d words, %d letters and %d unique letters\n", len(pngrm), len(strings.Join(pngrm, "")), len(letters))
	}
}
