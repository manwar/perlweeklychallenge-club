package main

import "testing"

func TestOutermostParentheses(t *testing.T) {
	tests := []struct {
		s    string
		want string
	}{
		{"()()()", ""},
		{"(((())))", "((()))"},
		{"(()())(())", "()()()"},
		{"()((()))()", "(())"},
		{"(()(()))(()())", "()(())()()"},
	}
	for _, tt := range tests {
		got := outermostParentheses(tt.s)
		if got != tt.want {
			t.Errorf("outermostParentheses(%v) = %v; want = %v", tt.s, got, tt.want)
		}
	}
}
