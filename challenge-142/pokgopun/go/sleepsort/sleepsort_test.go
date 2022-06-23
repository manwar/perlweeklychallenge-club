package sleepsort

import (
	"fmt"
	"sort"
	"testing"
	"time"

	"github.com/google/go-cmp/cmp"
)

var blackhole []uint

func BenchmarkSort(b *testing.B) {
	s := [][]uint{
		[]uint{3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5, 9},
		[]uint{2, 7, 1, 8, 2, 8, 1, 8, 2, 8, 4, 5, 9},
	}
	r := make([][]uint, 2)
	copy(r, s)
	for _, v := range r {
		sort.SliceStable(v, func(i, j int) bool {
			return v[i] < v[j]
		})
	}
	//for _, d := range []time.Duration{time.Nanosecond, time.Microsecond, time.Millisecond, time.Second} {
	for _, d := range []time.Duration{time.Nanosecond, time.Microsecond, time.Millisecond} {
		b.Run(fmt.Sprintf("Sort-%v", d), func(b *testing.B) {
			for j := 0; j < b.N; j++ {
				for i, v := range s {
					res := Sort(v, d)
					//blackhole = res
					/**/
					if diff := cmp.Diff(r[i], res); diff != "" {
						//b.Error(diff)
						b.Error("not in ascending order =>", res)
					}
					/**/
				}
			}
		})
	}
}
