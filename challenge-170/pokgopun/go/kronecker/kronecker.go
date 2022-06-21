package kronecker

import (
	"errors"
	"fmt"
	"strconv"
	"strings"
)

func Product(a [][]int, b [][]int) ([][]int, error) {
	if !isMatrix(a) || !isMatrix(b) {
		return [][]int{}, errors.New("not a matrix")
	}
	r := make([][]int, len(a)*len(b))
	for i := 0; i < len(a); i++ {
		o := i * len(b)
		for j := 0; j < len(a[i]); j++ {
			for p := 0; p < len(b); p++ {
				for q := 0; q < len(b[p]); q++ {
					r[p+o] = append(r[p+o], b[p][q]*a[i][j])
				}
			}
		}
	}
	return r, nil
}
func isMatrix(m [][]int) bool {
	if len(m) < 1 {
		return false
	}
	l := len(m[0])
	if l < 1 {
		return false
	}
	for _, v := range m[1:] {
		if l != len(v) {
			return false
		}
	}
	return true
}
func MatrixString(str string, s [][]int) string {
	var max int
	for i := 0; i < len(s); i++ {
		for j := 0; j < len(s[i]); j++ {
			if max < s[i][j] {
				max = s[i][j]
			}
		}
	}
	pw := len(strconv.Itoa(max))
	var b strings.Builder
	b.WriteString(fmt.Sprintf("%[1]*s = %[3]*v\n", len(str), str, pw, s[0]))
	for _, v := range s[1:] {
		b.WriteString(fmt.Sprintf("%[1]*s   %[3]*v\n", len(str), "", pw, v))
	}
	return b.String()
}
