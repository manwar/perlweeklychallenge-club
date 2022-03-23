package main

import (
	"fmt"
	"strings"
)

const exist = `
PELR, PREL, PERL, PRLE, PLER, PLRE, EPRL, EPLR, ERPL,
ERLP, ELPR, ELRP, RPEL, RPLE, REPL, RELP, RLPE, RLEP,
LPER, LPRE, LEPR, LRPE, LREP
`

func main() {
	e := "PERL"
	fmt.Printf("From the possible permutation of the string '%s' below:\n%s\n", e, exist)
	fmt.Println("Found the missing one(s) below:")
	pTree("", e)
}
func pTree(c, e string) {
	if e == "" {
		if !strings.Contains(exist, c) {
			fmt.Println(c)
		}
		return
	}
	for i := 0; i < len(e); i++ {
		et, ct := e, c
		ct += string(et[i])
		et = string(et[0:i]) + string(et[i+1:])
		pTree(ct, et)
	}
}
