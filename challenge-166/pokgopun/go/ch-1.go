package main

import (
	"bufio"
	"log"
	"os"
	"regexp"
	"sort"
	"strings"
)

func main() {
	var ds struct {
		wib  string
		wibs []string
	}
	//ds.wibs = make([][]byte, 40)
	f, err := os.Open("../../../data/dictionary.txt")
	if err != nil {
		log.Fatal(err)
	}
	defer f.Close()
	scanner := bufio.NewScanner(f)
	//scanner.Split(bufio.ScanWords)
	re := regexp.MustCompile(`^[abcdefolist]{2,8}$`)
	if err != nil {
		log.Fatal(err)
	}
	for scanner.Scan() {
		ds.wib = scanner.Text()
		if re.MatchString(ds.wib) {
			ds.wibs = append(ds.wibs, ds.wib)
		}
	}
	re = regexp.MustCompile(`[abcdef]`)
	sort.SliceStable(ds.wibs, func(i, j int) bool {
		lenOddI := len(re.ReplaceAllString(ds.wibs[i], ""))
		lenOddJ := len(re.ReplaceAllString(ds.wibs[j], ""))
		if lenOddI == lenOddJ {
			return len(ds.wibs[i]) > len(ds.wibs[j])
		} else {
			return lenOddI < lenOddJ
		}
	})
	r := strings.NewReplacer("o", "0", "l", "1", "i", "1", "s", "5", "t", "7")
	w := bufio.NewWriter(os.Stdout)
	for _, v := range ds.wibs {
		w.WriteString(v + " => 0x" + r.Replace(v) + "\n")
	}
	w.Flush()
}
