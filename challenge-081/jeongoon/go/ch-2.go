/*
Ref:
https://golangdocs.com/reading-files-in-golang
https://golangdocs.com/split-string-in-golang
https://golang.org/pkg/sort/
*/

/* test with: go run ./ch-1.go
# reading from file named "input" in PWD
*/

package main
import (
	"fmt"
	"io/ioutil"
	"log"
	"sort"
	"strings"
)

func FilterStr(vs string, fs []string) string {
	var vss []string
	vslen := len(vs)

	through_string:
	for i := 0; i < vslen; {
		for _, f := range fs {
			flen := len(f)
			if i+flen >= vslen {
				break through_string
			}
			subv := vs[i:i+flen]
			if  subv == f {
				i += flen
				continue through_string
			}
		}
		vss = append( vss, vs[i:i+1] )
		i++
	}
	return strings.Join( vss, "" )
}

type WordBag map[string]int
type FrequencyToWords map[int][]string

func (wb *WordBag) FromSlice(ws []string) {
	for _, w := range ws {
		(*wb)[w]++
	}
}

func (f2w *FrequencyToWords) Add(c int, w string) {
	(*f2w)[c] = append( (*f2w)[c], w )
}

func (f2w *FrequencyToWords) Find(freq int) ([]string, bool) {
	words, ok := (*f2w)[freq]
	return words, ok
}

func (wb *WordBag) ExportFrequencyToWords() ([]int, *FrequencyToWords) {
	frq_only := []int{}
	f2w := make(FrequencyToWords)

	for word, count := range (*wb) {
		found := false
		for _, cnt := range (frq_only) {
			if count == cnt {
				found = true
				break
			}
		}
		if ! found {
			frq_only = append(frq_only, count)
		}
		f2w.Add(count, word)
	}
	sort.Ints(frq_only) // sorted in place
	return frq_only, &f2w
}

func main() {
	content, err := ioutil.ReadFile("input")
	if err != nil {
		log.Fatal(err)
	}

	words := strings.Fields(
		FilterStr( string(content),
			[]string{ ".", ",", "(", ")", "\"", "'s", "--" },
		) )
	bag := make(WordBag)
	bag.FromSlice(words)
	frq_sorted, freq_to_words := bag.ExportFrequencyToWords()
	for _, frq := range(frq_sorted) {
		ws, ok := freq_to_words.Find(frq)
		if ok {
			sort.Strings(ws)
			fmt.Printf("%d\t%v\n", frq, strings.Join(ws, " "))
		}
	}
}
