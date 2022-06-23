/*
You are given a string, $s, containing mathematical expression.

Write a script to print the result of the mathematical expression. To keep it simple, please only accept + - * ().
*/
package main

import (
	"fmt"
	"log"
	"os"

	"github.com/Knetic/govaluate"
)

func main() {
	if len(os.Args) < 2 {
		os.Args = append(os.Args, "10 + 20 - 5", "(10 + 20 - 5) * 2", "8 * .7 - (3 - 13.5)")
	}
	for _, v := range os.Args[1:] {
		expression, err := govaluate.NewEvaluableExpression(v)
		result, err := expression.Evaluate(nil)
		if err != nil {
			log.Fatal(err)
		}
		fmt.Printf("Input: s = %q\nOutput: %v\n\n", v, result)
	}
}
