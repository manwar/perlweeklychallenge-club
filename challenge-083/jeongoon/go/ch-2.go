package main

import (
	"os"
	"fmt"
	"strconv"
)

func usage() {
	fmt.Println( "Usage: go run ch-2.go <natural numbers> ..." );
}

type MaybeNat string

func (str MaybeNat) Nat() Nat {
	n, err := strconv.Atoi(string(str))
	if err == nil {
		return(Nat(n))
	} else {
		return(Nat(0))
	}
}

func (str MaybeNat) isNatural() bool {
	return(str.Nat() > 0)
}

type Nat int
func (n Nat) String() string {
	return fmt.Sprintf("%d", n)
}

/*
 * Another my own version of making combinations without recursive call
 * explanation in perl:
 * https://github.com/jeongoon/pwc-by-me/blob/master/075/perl/CombinationsIndex.pm
 * I found that this implementation very fast in Perl,
 * so it will be the same in golang especially when compiled.
 */

func combinationsIndex( M int, N int ) [][]int {
	// M: number of selection ( 0 ... (M-1) )
	// N: number of choice
	if M < N {
		return [][]int{}
	}

	initRoomSize := M - N
	room := make([]int, N)
	pos  := make([]int, N)
	// https://stackoverflow.com/questions/39984957/is-it-possible-to-initialize-slice-with-specific-values
	for i := range room {
		room[i] = initRoomSize
	}
	for i := range pos {
		pos[i] = i
	}

	var combis [][]int
	new_case := make([]int, N)
	copy(new_case, pos)
	combis = append( [][]int{}, new_case )

	cursor := N - 1 // initial: index of last elements in selection

	for {
		if room[cursor] > 0 {
			room[cursor]--
			pos[cursor]++
			new_case := make([]int, N)
			copy(new_case, pos)
			combis = append(combis, new_case)
		} else {
			cursor_moved := false
			for i := cursor; i > 0; i-- {
				if room[i-1] > 0 {
					cursor = i-1
					cursor_moved = true
					break
				}
			}
			if cursor_moved {
				new_room := room[cursor] - 1
				base_pos := pos[cursor];
				for p, i := 1, cursor; i < N; i++ {
					room[i] = new_room
					pos[i]  = base_pos + p
					p++ // p++, i++ not working on for()
				}
				new_case := make([]int, N)
				copy(new_case, pos)
				combis = append(combis, new_case)
				cursor = N - 1
			} else {
				break
			}
		}

	}

	return combis
}

func main() {
	if len(os.Args[1:]) < 1 {
		usage();
		os.Exit(1);
	}

	var N []Nat
	all_good := true
	debug := false

	for _, str := range os.Args[1:] {
		if MaybeNat(str).isNatural() {
			N = append(N, MaybeNat(str).Nat())
		} else {
			all_good = false
			break
		}
	}

	if ! all_good {
		usage();
		os.Exit(2);
	}

	lenN := len(N)
	if lenN == 1 {
		// already minimum: no need to change
		fmt.Println( "0" );
		// but not error
		os.Exit(0);
	}

	totalSum := 0
	maxNum   := 0
	for _, n := range N {
		totalSum += int(n)
		if maxNum < int(n) {
			maxNum = int(n)
		}
	}

	minPositiveSum   := totalSum
	minPositiveElems := len(N)
	for i := 1; i < lenN; i++ {
		for _, cb := range combinationsIndex(lenN, i) {
			negativeGroupSum := 0
			for _, idx := range cb {
				negativeGroupSum += int(N[idx])
			}

			diff := totalSum - 2 * negativeGroupSum
			maybeNewElems := len(cb)

			if debug {
				fmt.Println( "before: ", diff,
					" with ", maybeNewElems,
					" <=>  ", minPositiveSum,
					" with ", minPositiveElems )
			}

			if diff >= 0 &&
				minPositiveSum >= diff {
				if minPositiveSum == diff {
					if minPositiveElems > maybeNewElems {
						minPositiveElems = maybeNewElems
					}
				} else { // minPositiveElems > diff
					minPositiveElems = maybeNewElems
				}

				minPositiveSum = diff
			}

			if debug {
				fmt.Println( "after:  ", diff,
					" with ", maybeNewElems,
					" <=>  ", minPositiveSum,
					" with ", minPositiveElems )
			}

			if minPositiveSum == 0 && minPositiveElems == 1 {
				break;
			}
		}
	}
	fmt.Println( minPositiveElems )
}
