/*
 * note: this is different approach when compared to my other solutions
 *
 * checking just interleaving or not (non-recursive version)
 *
 * Tested with:

  *  go run ch-2.go ABCDEFGHIJKLMNOPQRSTUVWXYZ ABCDEFGHIJKLMNOPQRSTUVWXYZ ABCABCDDEFGHIJEFKLGHIJKLMNMNOOPPQRQRSTUVSTWXYUVWXYZZ #  -> 1
  *  go run ch-2.go XY XX XYXX #  -> 1
  *  go run ch-2.go YX X XXY   #  -> 0
  */

package main

import (
	"os"
	"fmt"
)

type MaybeIntereaved string

type SavedPlace struct {
	Apos int
	Bpos int
}

func (C MaybeIntereaved) IsInterleavedFrom (A string, B string) bool {
	Alen, Blen, Clen := len(A), len(B), len(C)
	if Alen + Blen != Clen {
		return false
	}

	savedPos := []SavedPlace{}

	checkingPlanB := false

	for Ai, Bi, Ci := 0, 0, 0 ;; Ci = Ai + Bi {
		if checkingPlanB {
			if len( savedPos ) > 0 {
				Ai = savedPos[0].Apos
				Bi = savedPos[0].Bpos
				savedPos = savedPos[1:]

				Ci = Ai + Bi
			} else {
				// there is no plan B ...
				return false

			}
		}

		if Ci == Clen {
			return true
		}
		if Ai == Alen {
			if B[Bi:] == string(C[Ci:]) {
				return true
			} else {
				checkingPlanB = true
				continue
			}
		} else if Bi == Blen {
			if A[Ai:] == string(C[Ci:]) {
				return true
			} else {
				checkingPlanB = true
				continue
			}
		}
		if A[Ai] == B[Bi] {
			if A[Ai] != C[Ci] {
				checkingPlanB = true
			}  else {
				// remember this node
				savedPos = append(
					[]SavedPlace{ SavedPlace { Apos: Ai,
						Bpos: (Bi+1) } }, savedPos...)
				// try plan A first
				Ai++
			}
		} else {
			if A[Ai] == C[Ci] {
				Ai++
			} else if B[Bi] == C[Ci] {
				Bi++
			} else {
				checkingPlanB = true
			}
		}
	}
}

func usage() {
	fmt.Println( "Usage: go run ch-2.go " +
		"<string> <string> <may be interleaved string>\n" )
}

func main() {
	if len(os.Args[1:]) != 3 {
		usage();
		os.Exit(1);
	}
	A, B, C := os.Args[1], os.Args[2], os.Args[3]

	if MaybeIntereaved(C).IsInterleavedFrom(A, B) {
		fmt.Println( "1" )
	} else {
		fmt.Println( "0" )
	}
}
