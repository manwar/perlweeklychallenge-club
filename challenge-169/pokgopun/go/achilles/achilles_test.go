package achilles

import "testing"

func TestNewAchlls(t *testing.T) {
	res := NewAchlls(20).String()
	ans := "72, 108, 200, 288, 392, 432, 500, 648, 675, 800, 864, 968, 972, 1125, 1152, 1323, 1352, 1372, 1568, 1800"
	if res != ans {
		t.Error("incorrect result: expected " + ans + ", got " + res)
	}
}
