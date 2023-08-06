// https://theweeklychallenge.org/blog/perl-weekly-challenge-228/
/*
Task 2: Empty Array
Submitted by: Mohammad S Anwar
You are given an array of integers in which all elements are unique.

Write a script to perform the following operations until the array is empty and return the total count of operations.


If the first element is the smallest then remove it otherwise move it to the end.

Example 1
Input: @int = (3, 4, 2)
Ouput: 5

Operation 1: move 3 to the end: (4, 2, 3)
Operation 2: move 4 to the end: (2, 3, 4)
Operation 3: remove element 2: (3, 4)
Operation 4: remove element 3: (4)
Operation 5: remove element 4: ()
Example 2
Input: @int = (1, 2, 3)
Ouput: 3

Operation 1: remove element 1: (2, 3)
Operation 2: remove element 2: (3)
Operation 3: remove element 3: ()
*/

package main

import "fmt"

func main() {
	for _, data := range []struct {
		input  []int
		output int
	}{
		{[]int{3, 4, 2}, 5},
		{[]int{1, 2, 3}, 3},
	} {
		fmt.Println(CountEmptyOp(data.input).Count() == data.output)
	}
}

type CountEmptyOp []int

func (ceo CountEmptyOp) min() int {
	if len(ceo) == 0 {
		return 0
	}
	min := ceo[0]
	for _, v := range ceo[1:] {
		if v < min {
			min = v
		}
	}
	return min
}

func (ceo CountEmptyOp) Count() int {
	count := 0
	for len(ceo) > 0 {
		count += 1
		if ceo[0] != ceo.min() {
			ceo = append(ceo, ceo[0])
		}
		ceo = ceo[1:]
	}
	return count
}
