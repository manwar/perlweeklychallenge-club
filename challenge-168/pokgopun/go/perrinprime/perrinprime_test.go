package perrinprime

import "testing"

func TestNewPerrinPrime(t *testing.T) {
	res := NewPerrinPrime(13).String()
	ans := "2, 3, 5, 7, 17, 29, 277, 367, 853, 14197, 43721, 1442968193, 792606555396977"
	if res != ans {
		t.Error("incorrect result: expected " + ans + ", got " + res)
	}
}
