//# https://theweeklychallenge.org/blog/perl-weekly-challenge-291/
/*#

Task 2: Poker Hand Rankings

Submitted by: [46]Robbie Hatley
     __________________________________________________________________

   A draw poker hand consists of 5 cards, drawn from a pack of 52: no
   jokers, no wild cards. An ace can rank either high or low.

   Write a script to determine the following three things:
1. How many different 5-card hands can be dealt?
2. How many different hands of each of the 10 ranks can be dealt?
   See here for descriptions of the 10 ranks of Poker hands:
   https://en.wikipedia.org/wiki/List_of_poker_hands#Hand-ranking_categories
3. Check the ten numbers you get in step 2 by adding them together
   and showing that they're equal to the number you get in step 1.
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 20th October
   2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

func main() {
	io.WriteString(os.Stdout, cmp.Diff(newPokerHand().sum(), cnr(52, 5))) // blank if ok, otherwise show the difference
}

func cnr(n, r int) int {
	c := 1
	nmrt := n
	mx := max(r, n-r)
	dmnt := min(r, n-r)
	for nmrt > mx {
		c *= nmrt
		nmrt--
		if dmnt > 1 && c%dmnt == 0 {
			c /= dmnt
			dmnt--
		}
	}
	for dmnt > 1 {
		c /= dmnt
		dmnt--
	}
	return c
}

type pokerHand map[string]func() int

func (ph pokerHand) sum() int {
	c := 0
	for _, f := range ph {
		c += f()
	}
	return c
}

func newPokerHand() pokerHand {
	ph := pokerHand{
		"straightFlush": straightFlush,
		"fourOfKind":    fourOfKind,
		"fullHouse":     fullHouse,
		"flush":         flush,
		"straight":      straight,
		"threeOfKind":   threeOfKind,
		"twoPair":       twoPair,
		"onePair":       onePair,
		"highCard":      highCard,
	}
	return ph
}

func straightFlush() int {
	// select 1 of 4 symbols which yields [4], then select 5 consecutives starting from 2 (2..6) to 10 (10..A) which yields [9]
	return 4 * 9
}

func fourOfKind() int {
	// select 1 of 13 variations (2..A) which yields [13], then select the remaining one card from 52 - 4 which yields [48]
	return 13 * 48
}

func fullHouse() int {
	// for 3ofKind, select 1 of 13 variations (2..A) which yields [13], then select 3 combo from 4 symbols [math.comb(4,3)]
	// for pair, select 1 of the remaining 12 variations which yields [12], then select 2 combo from 4 symbols [math.comb(4,2)]
	return 13 * cnr(4, 3) * 12 * cnr(4, 2)
}

func flush() int {
	// select 1 of 4 symbols which yields [4], then select 5 combo from 13 variations [math.comb(13,5)]
	// however, to avoid the 5 cards become straightFlush, deduct [straightFlush()]
	return 4*cnr(13, 5) - straightFlush()
}

func straight() int {
	// for straight + straightFlush, select 5 consecutives starting from 2 (2..6) to 10 (10..A) which yields [9]
	// ...then the 5 consecutives each can have 4 variations which yields 4^5 [4*4*4*4*4]
	// finally, deduct straightFlush
	return 9*4*4*4*4*4 - straightFlush()
}

func threeOfKind() int {
	// select 1 of 13 variations for threeOfKind which yields [13]
	// symbol variations of threeOfKind is [math.comb(4,3)]
	// select 2 of the remaining 12 variations for the 2 different kind cards which yields [math.comb(12,2)]
	// symbol variations for the 2 different kind cards are [4 * 4]
	return 13 * cnr(4, 3) * cnr(12, 2) * 4 * 4
}

func twoPair() int {
	// select 2 of 13 kinds for the two pair [math.comb(13,2)]
	// symbol variations of each pair is 2 of 4 [math.comb(4,2) * math.comb[4,2)]]
	// 11 variations of kind for the last card [11], 4 symbol variations [4]
	return cnr(13, 2) * cnr(4, 2) * cnr(4, 2) * 11 * 4
}

func onePair() int {
	// select 13 varations of kind for the lone pair [13], symbol variations is 2 of 4 [math.comb(4,2)]
	// select 3 from 12 variations for the rest 3 different kind cards [math.comb(12,3)]
	// symbol variations of the rest 3 different kind cards is [4 * 4 * 4]
	return 13 * cnr(4, 2) * cnr(12, 3) * 4 * 4 * 4
}

func highCard() int {
	// select 5 of 13 variations for the 5 different kind cards which yields [math.comb(13,5)]
	// symbol variations of the 5 cards is [4 * 4 * 4 * 4 * 4]
	// finally, to avoid the 5 cards become straight or flush or straighFlush, we deduect [straight()+flush()+straightFlush()]
	return cnr(13, 5)*4*4*4*4*4 - straight() - flush() - straightFlush()
}
