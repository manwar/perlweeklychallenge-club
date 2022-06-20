package homeprime

import (
	"math/big"
	"strings"
	"testing"
)

const series string = "2, 3, 211, 5, 23, 7, 3331113965338635107, 311, 773, 11, 223, 13, 13367, 1129, 31636373, 17, 233, 19, 3318308475676071413, 37, 211, 23, 331319, 773, 3251, 13367, 227, 29, 547, 31, 241271, 311, 31397, 1129, 71129, 37, 373, 313, 3314192745739, 41, 379, 43, 22815088913, 3411949, 223, 47, 6161791591356884791277, -1"

func TestNewHomePrime(t *testing.T) {
	for i, ans := range strings.Split(series, ", ") {
		res := NewHomePrime(new(big.Int).SetInt64(int64(i) + 2)).String()
		if res != ans {
			t.Error("incorrect result: expected " + ans + ", got " + res)
		}
	}
}
