package main

import (
	"testing"
)

func TestReplaceE(t *testing.T) {
	input := "Perl Weekly Challenge"
	expectedCount := 5
	expectedReplaced := "PErl WEEkly ChallEngE"
	count, replaced := replaceE(input)
	if count != expectedCount {
		t.Errorf("expected count %d, got %d", expectedCount, count)
	}
	if replaced != expectedReplaced {
		t.Errorf("expected replaced %s, got %s", expectedReplaced, replaced)
	}
}
