package main

/* tested with:
 * go run ch-1.go 1.1 0.8 0.4 0.2 2.3 1.1 0.4 0.9 4.3
 * 1 as 1.0 < (0.200 + 0.400 + 0.800) < 2.0
 */

import (
	"os"
	"fmt"
	"strconv"
	"strings"
	"sort"
)

func usage () {
	fmt.Println( "Usage: go run ch-1.go <real numbers> ..." );
}

type combiIter struct {
	dlen int // data length
	nsel int // number of selection
	ncsr int // next cursor
	room []int
	pos  []int
}

// adapted from challenge-083/jeongoon/ch-2.go
// this combinations implentation keep the status into combiIter
// and give next combination when calling nextIndices()
func lazyCombinationsIndex( M int, N int ) *combiIter {
	iter := &combiIter{
		M,
		N,
		N-1,
		make([]int, N),
		make([]int, N),
	}

	initRoomSize := M - N

	for i := 0; i < (N-1); i++ {
		iter.room[i] = initRoomSize
		iter.pos[i]  = i
	}
	// note: we'll increase when nextIdices() called for the first time.
	iter.room[N-1] = initRoomSize + 1
	iter.pos[N-1]  = N - 2;

	return iter
}

func (ci *combiIter) nextIndices() []int {
	var new_case []int

	if ci.room[ci.ncsr] > 0 {
		ci.room[ci.ncsr]--
		ci.pos[ci.ncsr]++
		new_case = make([]int, ci.nsel)
		copy(new_case, ci.pos)
		return new_case
	} else {
		cursor_moved := false
		for i := ci.ncsr; i > 0; i-- {
			if ci.room[i-1] > 0 {
				ci.ncsr = i - 1;
				cursor_moved = true
				break
			}
		}
		if cursor_moved {
			new_room := ci.room[ci.ncsr] - 1
			base_pos := ci.pos[ci.ncsr];
			for p, i := 1, ci.ncsr; i < ci.nsel; i++ {
				ci.room[i] = new_room
				ci.pos[i] = base_pos + p
				p++
			}
			new_case = make([]int, ci.nsel)
			copy(new_case, ci.pos)
			ci.ncsr = ci.nsel - 1
		} else {
			new_case = []int{}
		}
	}
	return new_case
}

func parseStringsToFloat64s( args []string ) []float64 {
	var result []float64
	for i, maybe_f := range args {
		f, err := strconv.ParseFloat(maybe_f, 64)
		if err == nil {
			result = append(result, f)
		} else {
			fmt.Fprintf(os.Stderr,
				"wrong float value: [%d] [%s]\n", i, maybe_f)
		}
	}
	return result
}

func tidyList( flist []float64 ) []float64 {
	var result []float64
	sorted := flist  // copy
	sort.Float64s(sorted) // sort (in place)

	// only numbers < 2.0
	for _, f := range(sorted) {
		if f < 2.0 {
			result = append(result, f)
		}
	}
	return result
}

func main() {
	if len(os.Args[1:]) < 3 {
		usage();
		os.Exit(1);
	}

	flist_ := parseStringsToFloat64s(os.Args[1:])
	flist  := tidyList( flist_ )

	it := lazyCombinationsIndex(len(flist), 3)
	var foundTripletStrs []string
	for {
		tripletIndices := it.nextIndices();
		if len(tripletIndices) == 0 {
			break
		}

		sum := 0.0;
		for _, idx := range( tripletIndices ) {
			sum += flist[idx]
		}
		if sum > 1.0 && sum < 2.0 {
			for _, idx := range( tripletIndices ) {
				fStr := strconv.
					FormatFloat(flist[idx], 'f', 3, 64)
				foundTripletStrs = append(foundTripletStrs,fStr)
			}
			break
		}
	}

	if len(foundTripletStrs) == 0 {
		fmt.Println("0");
		os.Exit(2);
	} else {
		fmt.Println("1 as 1.0 < (" +
			strings.Join(foundTripletStrs, " + ") +
			") < 2.0")
		os.Exit(0);
	}
}
