package ch2

import "testing"

func TestStringDifference(t *testing.T) {
	tests := []struct {
		words []string
		want  string
	}{
		{[]string{"ab", "bc", "cd", "zy"}, "zy"},
		{[]string{"cba", "fed", "azy"}, "azy"},
		{[]string{"pop", "ada", "beb", "cfc"}, "pop"},
		{[]string{"aaaa", "zzzz", "mmmm", "aaba"}, "aaba"},
		{[]string{"aceg", "bdfh", "cegi", "azbz"}, "azbz"},
	}

	for _, tt := range tests {
		got, err := stringDifference(tt.words)
		if err != nil {
			t.Errorf("stringDifference(%v) returned error: %v", tt.words, err)
			continue
		}
		if got != tt.want {
			t.Errorf("stringDifference(%v) = %q; want %q", tt.words, got, tt.want)
		}
	}
}
