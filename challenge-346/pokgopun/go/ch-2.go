//# https://theweeklychallenge.org/blog/perl-weekly-challenge-346/
/*#

Task 2: Magic Expression

Submitted by: [45]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string containing only digits and a target integer.

   Write a script to insert binary operators +, - and * between the digits
   in the given string that evaluates to target integer.

Example 1

Input: $str = "123", $target = 6
Output: ("1*2*3", "1+2+3")

Example 2

Input: $str = "105", $target = 5
Output: ("1*0+5", "10-5")

Example 3

Input: $str = "232", $target = 8
Output: ("2*3+2", "2+3*2")

Example 4

Input: $str = "1234", $target = 10
Output: ("1*2*3+4", "1+2+3+4")

Example 5

Input: $str = "1001", $target = 2
Output: ("1+0*0+1", "1+0+0+1", "1+0-0+1", "1-0*0+1", "1-0+0+1", "1-0-0+1")
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 9th November
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"go/ast"
	"go/parser"
	"go/token"
	"io"
	"iter"
	"os"
	"strconv"
	"strings"

	"github.com/google/go-cmp/cmp"
)

type SegmentCombo iter.Seq[[]int]

func (sc SegmentCombo) process(n, l int, s []int, yield func([]int) bool) {
	if n == 1 {
		if !yield(append(s, l)) {
			return
		}
	} else {
		for i := 1; i < l; i++ {
			sc.process(n-1, l-i, append(s, i), yield)
		}
	}
}

func segCmb(n, l int) SegmentCombo {
	return func(yield func([]int) bool) {
		new(SegmentCombo).process(n, l, make([]int, 0, n), yield)
	}
}

func evlCmb(n int, dgtStr string) iter.Seq[[]string] {
	return func(yield func([]string) bool) {
		for seg := range segCmb(n, len(dgtStr)) {
			l := len(seg)
			var strs []string
			i := 0
			for _, v := range seg {
				s := dgtStr[i : i+v]
				i += v
				if len(s) > 1 && s[0] == 48 {
					break
				}
				l--
				if l == 0 {
					strs = append(strs, s)
				} else {
					strs = append(strs, s, "+")
				}
			}
			if l == 0 {
				if !yield(strs) {
					return
				}
			}
		}
	}
}

func bPowerN(b, n int) int {
	v := b
	for n > 1 {
		v *= b
		n--
	}
	return v
}

func Me(s []string) map[string]struct{} {
	res := make(map[string]struct{})
	for _, v := range s {
		res[v] = struct{}{}
	}
	return res
}

func me(dgtStr string, target int) map[string]struct{} {
	l := len(dgtStr)
	if l < 2 {
		return nil
	}
	ops := []rune{'+', '-', '*'}
	b := len(ops)
	res := make(map[string]struct{})
	for n := 2; n < l+1; n++ {
		for evl := range evlCmb(n, dgtStr) {
			for d := range bPowerN(b, n-1) {
				i := 2*n - 1
				for d > 0 {
					i -= 2
					evl[i] = string(ops[d%b])
					d /= b
				}
				for i > 1 {
					i -= 2
					evl[i] = string(ops[0])
				}
				evlStr := strings.Join(evl, "")
				evlRes, _ := eval(evlStr)
				if evlRes == target {
					res[evlStr] = struct{}{}
				}
			}
		}
	}
	//fmt.Println(res)
	return res
}

func Eval(exp ast.Expr) int {
	switch exp := exp.(type) {
	case *ast.BinaryExpr:
		return EvalBinaryExpr(exp)
	case *ast.BasicLit:
		switch exp.Kind {
		case token.INT:
			i, _ := strconv.Atoi(exp.Value)
			return i
		}
	}
	return 0
}
func EvalBinaryExpr(exp *ast.BinaryExpr) int {
	left := Eval(exp.X)
	right := Eval(exp.Y)
	switch exp.Op {
	case token.ADD:
		return left + right
	case token.SUB:
		return left - right
	case token.MUL:
		return left * right
	case token.QUO:
		return left / right
	}
	return 0
}
func eval(expStr string) (int, error) {
	exp, err := parser.ParseExpr(expStr)
	if err != nil {
		return 0, err
	}
	return Eval(exp), nil
}

func main() {
	for _, data := range []struct {
		dgtStr string
		target int
		output []string
	}{
		{"123", 6, []string{"1*2*3", "1+2+3"}},
		{"105", 5, []string{"1*0+5", "10-5"}},
		{"232", 8, []string{"2*3+2", "2+3*2"}},
		{"1234", 10, []string{"1*2*3+4", "1+2+3+4"}},
		{"1001", 2, []string{"1+0*0+1", "1+0+0+1", "1+0-0+1", "1-0*0+1", "1-0+0+1", "1-0-0+1"}},
		//{"1234567890", 1979, []string{"1+2*3+45*6*7-8+90", "1+2-3+45*6*7+89-0", "1+2-3+45*6*7+89+0"}},
		//{"12304560789", 8532, []string{"1*2*30+4*5*60*7+8*9"}},
	} {
		io.WriteString(os.Stdout, cmp.Diff(me(data.dgtStr, data.target), Me(data.output))) // blank if ok, otherwise show the difference
	}
}
