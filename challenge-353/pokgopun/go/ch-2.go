//# https://theweeklychallenge.org/blog/perl-weekly-challenge-353/
/*#

Task 2: Validate Coupon

Submitted by: [74]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given three arrays, @codes, @names and @status.

   Write a script to validate codes in the given array.
A code is valid when the following conditions are true:
- codes[i] is non-empty and consists only of alphanumeric characters (a-z, A-Z,
0-9) and underscores (_).
- names[i] is one of the following four categories: "electronics", "grocery", "p
harmacy", "restaurant".
- status[i] is true.

   Return an array of booleans indicating validity: output[i] is true if
   and only if codes[i], names[i] and status[i] are all valid.

Example 1

Input: @codes  = ("A123", "B_456", "C789", "D@1", "E123")
       @names  = ("electronics", "restaurant", "electronics", "pharmacy", "groce
ry")
       @status = ("true", "false", "true", "true", "true")
Output: (true, false, true, false, true)

Example 2

Input: @codes  = ("Z_9", "AB_12", "G01", "X99", "test")
       @names  = ("pharmacy", "electronics", "grocery", "electronics", "unknown"
)
       @status = ("true", "true", "false", "true", "true")
Output: (true, true, false, true, false)

Example 3

Input: @codes  = ("_123", "123", "", "Coupon_A", "Alpha")
       @names  = ("restaurant", "electronics", "electronics", "pharmacy", "groce
ry")
       @status = ("true", "true", "false", "true", "true")
Output: (true, true, false, true, true)

Example 4

Input: @codes  = ("ITEM_1", "ITEM_2", "ITEM_3", "ITEM_4")
       @names  = ("electronics", "electronics", "grocery", "grocery")
       @status = ("true", "true", "true", "true")
Output: (true, true, true, true)

Example 5

Input: @codes  = ("CAFE_X", "ELEC_100", "FOOD_1", "DRUG_A", "ELEC_99")
       @names  = ("restaurant", "electronics", "grocery", "pharmacy", "electroni
cs")
       @status = ("true", "true", "true", "true", "false")
Output: (true, true, true, true, false)
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 28th December
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

type bools []bool

type strs []str

type str string

func (s str) isCat() bool {
	return s == "electronics" || s == "grocery" || s == "pharmacy" || s == "restaurant"
}

func (s str) isCode() bool {
	for _, v := range s {
		if !(v == '_' || (v >= '0' && v <= '9') || (v >= 'a' && v <= 'z') || (v >= 'A' && v <= 'Z')) {
			return false
		}
	}
	return true
}

type input struct {
	codes, names, status strs
}

func (in input) process() bools {
	l := len(in.codes)
	bs := make(bools, l)
	for i := range l {
		if in.status[i] == "true" && in.names[i].isCat() && in.codes[i].isCode() {
			bs[i] = true
		}
	}
	return bs
}

func main() {
	for _, data := range []struct {
		input  input
		output bools
	}{
		{input{
			strs{"A123", "B_456", "C789", "D@1", "E123"},
			strs{"electronics", "restaurant", "electronics", "pharmacy", "grocery"},
			strs{"true", "false", "true", "true", "true"},
		}, bools{true, false, true, false, true}},
		{input{
			strs{"Z_9", "AB_12", "G01", "X99", "test"},
			strs{"pharmacy", "electronics", "grocery", "electronics", "unknown"},
			strs{"true", "true", "false", "true", "true"},
		}, bools{true, true, false, true, false}},
		{input{
			strs{"_123", "123", "", "Coupon_A", "Alpha"},
			strs{"restaurant", "electronics", "electronics", "pharmacy", "grocery"},
			strs{"true", "true", "false", "true", "true"},
		}, bools{true, true, false, true, true}},
		{input{
			strs{"ITEM_1", "ITEM_2", "ITEM_3", "ITEM_4"},
			strs{"electronics", "electronics", "grocery", "grocery"},
			strs{"true", "true", "true", "true"},
		}, bools{true, true, true, true}},
		{input{
			strs{"CAFE_X", "ELEC_100", "FOOD_1", "DRUG_A", "ELEC_99"},
			strs{"restaurant", "electronics", "grocery", "pharmacy", "electronics"},
			strs{"true", "true", "true", "true", "false"},
		}, bools{true, true, true, true, false}},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
