//# https://theweeklychallenge.org/blog/perl-weekly-challenge-289/
/*#

Task 2: Jumbled Letters

Submitted by: [51]Ryan Thompson
     __________________________________________________________________

   An Internet legend dating back to at least 2001 goes something like
   this:

     Aoccdrnig to a rscheearch at Cmabrigde Uinervtisy, it deosn’t mttaer
     in waht oredr the ltteers in a wrod are, the olny iprmoetnt tihng is
     taht the frist and lsat ltteer be at the rghit pclae. The rset can
     be a toatl mses and you can sitll raed it wouthit porbelm. Tihs is
     bcuseae the huamn mnid deos not raed ervey lteter by istlef, but the
     wrod as a wlohe.

   This supposed Cambridge research is unfortunately an urban legend.
   However, the effect has been studied. For example—and with a title that
   probably made the journal’s editor a little nervous—Raeding wrods with
   jubmled lettres: there is a cost by Rayner, White, et. al. looked at
   reading speed and comprehension of jumbled text.

   Your task is to write a program that takes English text as its input
   and outputs a jumbled version as follows:
    1. The first and last letter of every word must stay the same
    2. The remaining letters in the word are scrambled in a random order
       (if that happens to be the original order, that is OK).
    3. Whitespace, punctuation, and capitalization must stay the same
    4. The order of words does not change, only the letters inside the
       word

   So, for example, “Perl” could become “Prel”, or stay as “Perl,” but it
   could not become “Pelr” or “lreP”.

   I don’t know if this effect has been studied in other languages besides
   English, but please consider sharing your results if you try!
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 6th October
   2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"bytes"
	"io"
	"math/rand"
	"os"
	"regexp"
)

func scramble(bs []byte) []byte {
	l := len(bs)
	if l < 4 {
		return bs
	}
	r := make([]byte, l)
	r[0] = bs[0]
	r[l-1] = bs[l-1]
	bs = bs[1 : l-1]
	l -= 2
	for l > 1 {
		n := rand.Intn(l)
		r[l] = bs[n]
		copy(bs[n:], bs[n+1:])
		l--
	}
	r[1] = bs[0]
	return r
}

func main() {
	content := []byte(`Mechanical Sympathy
When you understand how a system is designed to be used, you can align with the design to gain optimal performance. For example, if you know that a certain type of memory is more efficient when addresses are multiples of a factor, you can optimize your performance by using data structure alignment.

`)
	io.Copy(os.Stdout, bytes.NewReader(content))
	pattern := regexp.MustCompile(`\w+`)
	io.Copy(os.Stdout, bytes.NewReader(pattern.ReplaceAllFunc(content, scramble)))
}
