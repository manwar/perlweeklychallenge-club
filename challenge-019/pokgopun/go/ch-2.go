package main

import (
	"bufio"
	"log"
	"os"
	"strconv"
	"strings"
)

func main() {
	var width int
	if len(os.Args) > 1 {
		n, err := strconv.ParseUint(os.Args[1], 10, 32)
		if err != nil {
			log.Fatal(err)
		}
		width = int(n)
	}
	// An artificial input source.
	const input = `Write a script that can wrap the given paragraph at a specified column using the greedy algorithm.`
	scanner := bufio.NewScanner(strings.NewReader(input))
	scanner.Split(bufio.ScanWords)
	var (
		b  []byte
		lw int
		ww int
	)
	w := bufio.NewWriter(os.Stdout)
	for scanner.Scan() {
		b = scanner.Bytes()
		ww = len(b)
		if lw+ww > width {
			w.WriteByte('\n')
			lw = 0
		}
		w.Write(append(b, ' '))
		lw += ww + 1
	}
	w.WriteByte('\n')
	w.Flush()
}
