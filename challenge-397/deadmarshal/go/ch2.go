package ch2

import (
	"cmp"
	"math/bits"
	"slices"
)

func reflect(e int) uint64 {
	u := uint64(e)
	return bits.Reverse64(u) >> bits.LeadingZeros64(u)
}

func binaryReflection(xs []int) []int {
	out := slices.Clone(xs)
	slices.SortFunc(out, func(a, b int) int {
		if c := cmp.Compare(reflect(a), reflect(b)); c != 0 {
			return c
		}
		return cmp.Compare(a, b)
	})
	return out
}
