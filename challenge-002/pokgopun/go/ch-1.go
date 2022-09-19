// Write a script or one-liner to remove leading zeros from positive numbers.
// Assume number can be float and zero
package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
)

func main() {
	if len(os.Args) > 1 {
		w := bufio.NewWriter(os.Stdout)
		var (
			f   float64
			err error
		)
		for _, v := range os.Args[1:] {
			//fmt.Println(strings.TrimLeft(v, "0"))
			f, err = strconv.ParseFloat(v, 64)
			if err != nil || f < 0 {
				log.Fatal("Not a positive number")
			}
			if f != 0 {
				v = strings.TrimLeft(v, "0")
			}
			w.WriteString(v + "\n")
		}
		w.Flush()
	} else {
		fmt.Println("Enter number to have its leading zeros removed")
	}
}
