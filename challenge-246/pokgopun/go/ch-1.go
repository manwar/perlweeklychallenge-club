//# https://theweeklychallenge.org/blog/perl-weekly-challenge-246/
/*#

Task 1: 6 out of 49

Submitted by: [46]Andreas Voegele
     __________________________________________________________________

   6 out of 49 is a German lottery.

   Write a script that outputs six unique random integers from the range 1
   to 49.

Output

3
10
11
22
38
49

Task 2: Linear Recurrence of Second Order
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"fmt"
	"math/rand"
	"time"
)

type gmLot struct {
	rg  *rand.Rand
	val [6]uint8
}

func newGmLot() gmLot {
	gl := gmLot{rg: rand.New(rand.NewSource(time.Now().UnixNano()))}
	gl.update()
	return gl
}

func (gl gmLot) String() string {
	return fmt.Sprint(gl.val)
}

func (gl *gmLot) update() {
	i := 0
	for _, v := range gl.rg.Perm(50)[:7] {
		if v != 0 {
			gl.val[i] = uint8(v)
			i++
		}
		if i == 6 {
			break
		}
	}
}

func (gl gmLot) isInRange() bool {
	for _, v := range gl.val {
		if v < 1 || v > 49 {
			return false
		}
	}
	return true
}

func (gl gmLot) isUnique() bool {
	m := make(map[uint8]bool)
	for _, v := range gl.val {
		if m[v] {
			return false
		}
		m[v] = true
	}
	return true
}

func (gl *gmLot) hasNoDupAfterN(n uint) bool {
	m := make(map[[6]uint8]bool)
	for i := uint(0); i < n; i++ {
		if m[gl.val] {
			//fmt.Println(m)
			return false
		}
		m[gl.val] = true
		//if i < n/2 {
		gl.update()
		//fmt.Println(gl)
		//}
	}
	//fmt.Println(m)
	return true
}

func main() {
	gl := newGmLot()
	fmt.Println(gl.isInRange(), gl.isUnique(), gl.hasNoDupAfterN(100), gl)
}
