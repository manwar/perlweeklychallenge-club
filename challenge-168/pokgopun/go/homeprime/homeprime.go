/*
You are given an integer greater than 1.

Write a script to find the home prime of the given number.

In number theory, the home prime HP(n) of an integer n greater than 1 is the prime number obtained by repeatedly factoring the increasing concatenation of prime factors including repetitions.
*/
package homeprime

import (
	"log"
	"math/big"

	"github.com/jbarham/primegen"
)

type abstractPrimegen struct {
	nextUint64 func() uint64
	reset      func()
}

func (apg abstractPrimegen) Next() *big.Int {
	return new(big.Int).SetUint64(apg.nextUint64())
}
func (apg abstractPrimegen) Reset() {
	apg.reset()
}

type bigPrimeGenerator interface {
	Next() *big.Int
	Reset()
}
type ppFactorizer struct {
	pg bigPrimeGenerator
}

func (ppf ppFactorizer) factor(n *big.Int) (s []*big.Int) {
	d := new(big.Int).Set(ppf.pg.Next())
	for {
		if new(big.Int).Mod(n, d).Cmp(big.NewInt(0)) != 0 {
			d.Set(ppf.pg.Next())
		} else {
			s = append(s, new(big.Int).Set(d))
			n.Div(n, d)
			if n.Cmp(big.NewInt(1)) == 0 {
				break
			} else if n.ProbablyPrime(0) {
				s = append(s, n)
				break
			}
		}
	}
	ppf.pg.Reset()
	return s
}

type homePrime struct {
	n, val *big.Int
	f      interface {
		factor(*big.Int) []*big.Int
	}
}

func (hp homePrime) String() string {
	return hp.val.String()
}
func (hp *homePrime) resolve() *homePrime {
	if hp.n.Cmp(big.NewInt(2)) == -1 {
		log.Fatal("input must be greater than 1")
	} else if hp.n.Cmp(big.NewInt(49)) == 0 || hp.n.Cmp(big.NewInt(77)) == 0 {
		hp.val = new(big.Int).SetInt64(-1)
		return hp
	}
	hp.val = new(big.Int).Set(hp.n)
	for !hp.val.ProbablyPrime(0) {
		//hp.val.SetString(strings.ReplaceAll(hp.f.factor(hp.val), " ", ""), 10)
		var str string
		for _, v := range hp.f.factor(hp.val) {
			str += v.String()
		}
		hp.val.SetString(str, 10)
		//fmt.Println(hp)
	}
	return hp
}
func NewHomePrime(n *big.Int) *homePrime {
	pg := primegen.New()
	var apg abstractPrimegen
	apg.nextUint64 = pg.Next
	apg.reset = pg.Reset
	var ppf ppFactorizer
	ppf.pg = apg
	var hp homePrime
	hp.f = ppf
	hp.n = new(big.Int).Set(n)
	return hp.resolve()
}
