package kronecker

import (
	"testing"

	"github.com/google/go-cmp/cmp"
)

func TestProduct(t *testing.T) {
	data := []struct {
		name   string
		a      [][]int
		b      [][]int
		ab     [][]int
		errMsg string
	}{
		{
			"2x2 x 2x2",
			[][]int{
				[]int{1, 2},
				[]int{3, 4},
			},
			[][]int{
				[]int{5, 6},
				[]int{7, 8},
			},
			[][]int{
				[]int{5, 6, 10, 12},
				[]int{7, 8, 14, 16},
				[]int{15, 18, 20, 24},
				[]int{21, 24, 28, 32},
			},
			"",
		},
		{
			"2x2 x 3x3",
			[][]int{
				[]int{1, 2},
				[]int{3, 4},
			},
			[][]int{
				[]int{1, 2, 3},
				[]int{4, 5, 6},
				[]int{7, 8, 9},
			},
			[][]int{
				[]int{1, 2, 3, 2, 4, 6},
				[]int{4, 5, 6, 8, 10, 12},
				[]int{7, 8, 9, 14, 16, 18},
				[]int{3, 6, 9, 4, 8, 12},
				[]int{12, 15, 18, 16, 20, 24},
				[]int{21, 24, 27, 28, 32, 36},
			},
			"",
		},
		{
			"3x3 x 2x2",
			[][]int{
				[]int{1, 2, 3},
				[]int{4, 5, 6},
				[]int{7, 8, 9},
			},
			[][]int{
				[]int{1, 2},
				[]int{3, 4},
			},
			[][]int{
				[]int{1, 2, 2, 4, 3, 6},
				[]int{3, 4, 6, 8, 9, 12},
				[]int{4, 8, 5, 10, 6, 12},
				[]int{12, 16, 15, 20, 18, 24},
				[]int{7, 14, 8, 16, 9, 18},
				[]int{21, 28, 24, 32, 27, 36},
			},
			"",
		},
		{
			"invalid x 2x2",
			[][]int{
				[]int{1},
				[]int{1, 2},
			},
			[][]int{
				[]int{1, 2},
				[]int{3, 4},
			},
			[][]int{},
			"not a matrix",
		},
		{
			"2x2 x blank",
			[][]int{
				[]int{1, 2},
				[]int{3, 4},
			},
			[][]int{},
			[][]int{},
			"not a matrix",
		},
		{
			"blank x invalid",
			[][]int{},
			[][]int{
				[]int{1, 2},
				[]int{},
			},
			[][]int{},
			"not a matrix",
		}}
	for _, d := range data {
		t.Run(d.name, func(t *testing.T) {
			res, err := Product(d.a, d.b)
			if diff := cmp.Diff(d.ab, res); diff != "" {
				t.Error(diff)
			}
			var errMsg string
			if err != nil {
				errMsg = err.Error()
			}
			if errMsg != d.errMsg {
				t.Errorf("Expected error message `%s`, got `%s`", d.errMsg, errMsg)
			}
		})
	}
}
