package main

import (
	"fmt"
	"io"
	"os"
	"sort"
	"strconv"
	"strings"

	"github.com/jbarham/primegen"
)

func main() {
	var count uint = 20
	fmt.Sscanf(strings.Join(os.Args[1:], " "), "%d", &count)
	var b strings.Builder
	pg := primegen.New()
	var skipTo uint64 = 100
	pg.SkipTo(skipTo)
	for count > 0 {
		n := strconv.FormatUint(pg.Next(), 10)
		l := len(n)
		if l%2 == 0 {
			skipTo *= 100
			pg.SkipTo(skipTo)
			continue
		}
		bs := []byte(n)
		var z int
		for _, v := range bs {
			if v == 48 {
				z++
				if z > 1 {
					goto skip
				}
			}
		}
		sort.SliceStable(bs, func(i, j int) bool {
			return true
		})
		if n[l/2]-48 == 0 && n == string(bs) {
			b.WriteString(", " + n)
			count--
		}
	skip:
	}
	io.WriteString(os.Stdout, b.String()[2:]+"\n")
}
