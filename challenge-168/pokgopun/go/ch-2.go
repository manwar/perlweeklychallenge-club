package main

import (
	"fmt"
	"log"
	"math"
	"math/big"
	"os"
	"strconv"
)

func main() {
	var hp homePrime
	hp.buildPrime(1_000_000)
	if len(os.Args) > 1 {
		for _, v := range os.Args[1:] {
			n, err := strconv.Atoi(v)
			if err != nil {
				log.Fatal(err)
			}
			fmt.Printf("HP(%d) = %d\n", n, hp.find(n))
		}
	} else {
		for i := 1; i <= 47; i++ {
			fmt.Printf("HP(%d) = %d\n", i, hp.find(i))
		}
	}
}

func (hp homePrime) find(n int) *big.Int {
	bi := big.NewInt(int64(n))
	if n == 1 {
		return bi
	}
	i := 1
	e := big.NewInt(4)
	for e.Cmp(bi) == -1 {
		e.Mul(e, big.NewInt(4))
		i++
	}
	for !bi.ProbablyPrime(i) {
		var str string
		f := hp.factor(bi)
		//fmt.Println(f)
		for _, v := range f {
			str += strconv.Itoa(int(v))
		}
		//fmt.Println(str)
		_, ok := bi.SetString(str, 0)
		if !ok {
			//fmt.Println("Failed on SetString for", bi)
			return big.NewInt(-1)
		}
	}
	return bi
}

func (hp *homePrime) buildPrime(n int) {
	hp.pmap = make([]bool, int(n)+1)
	for i := 2; i <= n; i++ {
		hp.pmap[i] = true
	}
	for i := 2; float64(i) <= math.Sqrt(float64(n)); i++ {
		j := i * i
		for j <= n {
			hp.pmap[j] = false
			j += i
		}

	}
	for i := 2; i < len(hp.pmap); i++ {
		if hp.pmap[i] {
			hp.plist = append(hp.plist, i)
		}
	}
}

func (hp *homePrime) factor(n *big.Int) (s []int) {
	if n.Cmp(big.NewInt(1)) == 1 {
		j := 1
		e := big.NewInt(4)
		for e.Cmp(n) == -1 {
			e.Mul(e, big.NewInt(4))
			j++
			//fmt.Println("In factor's e calculation => e=", e)
		}
		if n.ProbablyPrime(j) {
			return []int{int(n.Int64())}
		}
		i := 0
		m := new(big.Int)
		nextPrime := big.NewInt(2)
		for {

			if m.Mod(n, nextPrime).Cmp(big.NewInt(0)) != 0 {
				i++
				if i+1 > len(hp.plist) {
					l := len(hp.pmap)
					if l < 1_000_000_000 {
						hp.buildPrime(l * 1_000)
					} else {
						return []int{}
					}
				}
				nextPrime = big.NewInt(int64(hp.plist[i]))
			} else {
				s = append(s, int(nextPrime.Int64()))
				n.Div(n, nextPrime)
				if n.Cmp(big.NewInt(1)) == 0 {
					break
				} else if n.ProbablyPrime(j) {
					s = append(s, int(n.Int64()))
					break
				}
			}
		}
	}
	return s
}

type homePrime struct {
	pmap  []bool
	plist []int
}
