package main

import (
	"testing"
)

func TestBase35(t *testing.T) {
	if base35ToInt("A") != 10 {
		t.Errorf("base35ToInt(\"A\") = %d; expected 10", base35ToInt("A"))
	}
	if base35ToInt("1A") != 45 {
		t.Errorf("base35ToInt(\"1A\") = %d; expected 45", base35ToInt("1A"))
	}
	if intToBase35(45) != "1A" {
		t.Errorf("intToBase35(45) = %s; expected \"1A\"", intToBase35(45))
	}
	if intToBase35(12345) != "A2P" {
		t.Errorf("intToBase35(12345) = %s; expected \"A2P\"", intToBase35(12345))
	}
}
