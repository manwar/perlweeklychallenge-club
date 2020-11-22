package main

import (
	"os"
	"fmt"
	"strconv"
)

func usage() {
	fmt.Println( "Usage: go run ch-1.go " +
		"<M> <N> # select N from 1..M" )
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


// another my version of making combinations
// I thought there should be standard library. but I couldn't find yet.

// a non-recursive combination modified for challenge
func combinationsIndex( M int, N int ) [][]int {
	// M: number of selection ( 0 ... (M-1) )
	// N: number of choice
	if M < N {
		return [][]int{}
	}

	initRoomSize := M - N
	room := make([]int, N)
	for i := range room {
		room[i] = initRoomSize
	}
	num  := make([]int, N)
	for i := range num {
		num[i] = i+1
	}
/*
	pos  := make([]int, N)
	for i := range pos {
		pos[i] = i
	}
*/
	var combis [][]int
	new_case := make([]int, N)
	//copy(new_case, pos)
	copy(new_case, num)
	combis = append( [][]int{}, new_case )

	cursor := N - 1 // initial: index of last elements in selection

	for {
		if room[cursor] > 0 {
			room[cursor]--
			//pos[cursor]++
			num[cursor]++
			new_case := make([]int, N)
			//copy(new_case, pos)
			copy(new_case, num)
			combis = append( combis, new_case )
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
				//base_pos := pos[cursor];
				base_num := num[cursor];
				for p, i := 1, cursor; i < N; i++ {
					room[i] = new_room
					//pos[i]  = base_pos + p
					num[i]  = base_num + p
					p++ // p++, i++ not working on for()
				}
				new_case := make([]int, N)
				//copy(new_case, pos)
				copy(new_case, num)
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
	if len(os.Args[1:]) != 2 {
		usage();
		os.Exit(1);
	}

	var N []Nat
	all_good := true

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

	fmt.Println(combinationsIndex( int(N[0]), int(N[1]) ));
}
