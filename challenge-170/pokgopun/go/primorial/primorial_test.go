package primorial

import (
	"strings"
	"testing"
)

const ansString = "1, 2, 6, 30, 210, 2310, 30030, 510510, 9699690, 223092870, 6469693230, 200560490130, 7420738134810, 304250263527210, 13082761331670030, 614889782588491410, 32589158477190044730, 1922760350154212639070, 117288381359406970983270, 7858321551080267055879090"

func TestPrimorialNums(t *testing.T) {
	ans := strings.Split(ansString, ", ")
	for i, v := range PrimorialNums(uint(len(ans))) {
		res := v.String()
		if ans[i] != res {
			t.Error("incorrect result, expected " + ans[i] + ", got " + res)
		}
	}
}
