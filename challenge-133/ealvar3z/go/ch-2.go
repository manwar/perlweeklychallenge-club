package main

import (
	"fmt"
	"math/rand"
	"time"
)

func sumDigits(n uint) uint {
	var sum uint
	for n != 0 {
		sum += n % 10
		n /= 10
	}
	return sum
}

func sumFactors(n []uint) uint {
	var sum uint
	for i := range n {
		sum += sumDigits(n[i])
	}
	return sum
}

func factors(n uint) []uint {
	var i uint = 2
	fac := []uint{}
	for i*i <= n {
		if n%i != 0 {
			i++
		} else {
			n /= i
			fac = append(fac, i)
		}
	}
	if n > 1 {
		fac = append(fac, n)
	}
	return fac
}

func isSmithNum(n uint) bool {
	fac := factors(n)
	if len(fac) > 1 {
		if sumDigits(n) == sumFactors(fac) {
			return true
		}
	}
	return false
}

func genSmithNums() <-chan uint {
	// init our channel
	c := make(chan uint)

	// launch goroutine and send data to channel
	go func() {
		var i uint
		for i = 4; ; i++ {
			fac := factors(i)
			if len(fac) < 2 {
				continue
			}

			if isSmithNum(i) == true {
				// once you find it: fire for effect!
				c <- i
				time.Sleep(time.Duration(rand.Intn(1e3)) * time.Millisecond)
			}
		}
		close(c)
	}()
	return c
}

func main() {

	// generate our SmithNums
	mrSmith := genSmithNums()

	for i := 0; i < 10; i++ {
		// <- mrSmith read values from genSmithNums
		// and wait for a value to be sent
		fmt.Printf("%d\n", <-mrSmith)
	}
	fmt.Println("done")
}
