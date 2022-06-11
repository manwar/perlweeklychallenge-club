package main

//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-154
//

//
// Run as: go run ch-1.go < input-file
//

import (
    "fmt"
    "bufio"
    "os"
)

func main () {
    p := [24] string {
             "PERL\n", "PELR\n", "PREL\n", "PRLE\n", "PLER\n", "PLRE\n",
             "EPRL\n", "EPLR\n", "ERPL\n", "ERLP\n", "ELPR\n", "ELRP\n",
             "REPL\n", "RELP\n", "RPEL\n", "RPLE\n", "RLEP\n", "RLPE\n",
             "LERP\n", "LEPR\n", "LREP\n", "LRPE\n", "LPER\n", "LPRE\n",
    };
    var reader = bufio . NewReader (os. Stdin)
    for {
        var text, err = reader . ReadString ('\n')
        if (err != nil) {
            break
        }
        for i := 0; i < 24; i ++ {
            if (p [i] == text) {
                p [i] = ""
            }
        }
    }
    for _, x := range p {
        fmt . Print (x)
    }
}
