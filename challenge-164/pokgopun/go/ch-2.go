package main

import (
	"bufio"
	"os"
	"strconv"
)

func main() {
	//n := 10_000_000
	n := 8
	l := 10_000_000
	//l := 1000
	if len(os.Args) > 1 {
		r, err := strconv.Atoi(os.Args[1])
		if err == nil {
			n = r
		}
	}
	w := bufio.NewWriter(os.Stdout)
	w.WriteString("1")
	count := 1
	var h happy = make(map[int]bool)
	for i := 2; count < n && i <= l; i++ {
		if h.isHappy(i, []int{}) {
			w.WriteString(", " + strconv.Itoa(i))
			count++
		}
	}
	w.WriteString("\n")
	w.Flush()
	//fmt.Println(len(happy), happy)
}

type happy map[int]bool

func (h *happy) isHappy(i int, ht []int) bool {
	happy := *h
	b, ok := happy[i]
	if ok {
		return b
	}
	for _, v := range ht {
		if i == v {
			for _, v := range ht {
				happy[v] = false
			}
			return false
		}
	}
	var sum int
	//fmt.Print(i, " => ")
	for _, v := range strconv.Itoa(i) {
		v -= 48
		sum += int(v * v)
		//fmt.Printf("%v^2 ", v)
	}
	//fmt.Println("=>", sum)
	ht = append(ht, i)
	if sum == 1 {
		for _, v := range ht {
			happy[v] = true
		}
		return true
	}
	return h.isHappy(sum, ht)
}
