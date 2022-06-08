// Write a script to create a Palindromic Tree for the given string.
// All examples do not have a case that a letter happens more than twice in given words.
// As a result, will initially ignore the case here.
package main

import (
	"fmt"
	"os"
	"regexp"
	"sort"
	"strings"
)

func main() {
	var sample []string
	if len(os.Args) > 1 {
		sample = os.Args[1:]
	} else {
		sample = []string{
			"redivider",
			"deific",
			"rotors",
			"challenge",
			"champion",
			"christmas",
		}
	}
	for _, v := range sample {
		p := newPldt(v)
		fmt.Println(p)
	}
}

type pldt struct {
	word string
	seen map[string]bool
}

func newPldt(s string) (p pldt) {
	p.word = s
	p.seen = make(map[string]bool)
	return p
}

func (p pldt) find(b byte) (s []string) {
	for _, v := range regexp.MustCompile(string(b)+".*"+string(b)).FindAll([]byte(p.word), -1) {
		o := string(v)
		sort.SliceStable(v, func(i, j int) bool {
			return true
		})
		if o == string(v) {
			s = append(s, o)
		}
		//fmt.Println(string(v))
	}
	return s
}

func (p pldt) String() string {
	var b strings.Builder
	b.WriteString("Input: '" + p.word + "'\nOutput: ")
	for _, c := range []byte(p.word) {
		if p.seen[string(c)] {
			continue
		}
		p.seen[string(c)] = true
		b.Write([]byte{c, ' '})
		/**/
		for _, v := range p.find(c) {
			if p.seen[v] {
				continue
			}
			p.seen[v] = true
			b.WriteString(v + " ")
		}
		/**/
	}
	b.WriteByte('\n')
	return b.String()
}
