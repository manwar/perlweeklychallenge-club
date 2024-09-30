#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-289#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Jumbled Letters
Submitted by: Ryan Thompson

An Internet legend dating back to at least 2001 goes something like this:

|| Aoccdrnig to a rscheearch at Cmabrigde Uinervtisy, it deosn’t mttaer in waht
|| oredr the ltteers in a wrod are, the olny iprmoetnt tihng is taht the frist
|| and lsat ltteer be at the rghit pclae. The rset can be a toatl mses and you
|| can sitll raed it wouthit porbelm. Tihs is bcuseae the huamn mnid deos not
|| raed ervey lteter by istlef, but the wrod as a wlohe.

This supposed Cambridge research is unfortunately an urban legend. However, the
effect has been studied. For example—and with a title that probably made the
journal’s editor a little nervous—Raeding wrods with jubmled lettres: there is a
cost by Rayner, White, et. al. looked at reading speed and comprehension of
jumbled text.

Your task is to write a program that takes English text as its input and outputs a
jumbled version as follows:

1) The first and last letter of every word must stay the same
2) The remaining letters in the word are scrambled in a random order
   (if that happens to be the original order, that is OK).
3) Whitespace, punctuation, and capitalization must stay the same
4) The order of words does not change, only the letters inside the word

So, for example, “Perl” could become “Prel”, or stay as “Perl,” but it could not
become “Pelr” or “lreP”.

=cut

use v5.32;
use feature qw(signatures);
no warnings qw(experimental::signatures);
use common::sense;

use List::Util qw(shuffle);

sub jumbledLetters ($str) {
  $str =~ s{([a-z])([a-z]+)([a-z])}{$1.join('',shuffle split //,$2).$3}geisr;
}

say jumbledLetters(<<EOT); 
According to a research at Cambridge University, it doesn't matter in what order
the letters in a word are, the only important thing is that the first and last
letter be at the right place. The rest can be a total mess and you can still
read it without problem. This is because the human mind does not read every
letter by itsel, but the word as a whole.
EOT
