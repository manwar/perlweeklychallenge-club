package main

import "fmt"

func main() {
	// Generating the first twelve Pisano periods and their cycles
	// https://en.wikipedia.org/wiki/Pisano_period => section "Table"
	for n := 1; n <= 12; n++ {
		// Sequence for storing Fibonacci numbers
		fseq := []int{0, 1}
		// Sequence for calculating Pisano periods
		var mseq string
		// Avoid looping more than 1000 times during the calcuation
		for i := 0; i < 1000; i++ {
			f1 := fseq[1]
			f0 := fseq[0]
			// ascii offset for convert number 0-9 to string 0-9, 10-35 to A-Z, 36-61 to a-z
			var o int
			switch {
			case f0 < 10:
				o = 48
			case f0 < 36:
				o = 55
			default:
				o = 61
			}
			mseq += string(f0%n + o)
			// check for repeated cycle when mseq contains even number of charactors, that is when latest index is odd
			if i%2 == 1 {
				m := len(mseq) / 2
				if string(mseq[:m]) == string(mseq[m:]) {
					fmt.Println("n =", n, ",Pisano period =", m, ",Cycle =", mseq[:m])
					//fmt.Println("i = ", i)
					break
				}
			}
			// fn = f1 + f0 as fseq will contain only the latest two values
			// fseq = append(fseq, f1+f0)
			// We can just store fn%n instead of fn as (f1+f2)%n seems to be always equal to (f1%n + f0%n)%n
			fseq = append(fseq, (f1+f0)%n)
			// fseq to contain only the latest two values
			fseq = fseq[len(fseq)-2:]
		}
	}
}
