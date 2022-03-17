#!/opt/perl/bin/perl

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-155
#

#
# Run as: perl ch-1.pl
#

#
# Oh, gosh. Another "get the first N (with N fixed) numbers from
# an OEIS sequence". (Sequence A046066). And once again, dealing
# with prime numbers.  Utterly fucking boring.
#

#
# We assume Reo F. Fortune's conjecture is true (which it is for 
# the first 1000 values of the sequence, and we only need 8)
#

use ntheory":all";$p=$o=1;do{$o*=($m=$p=next_prime$p);$m=next_prime$m until
is_prime($o+$m);$f{$m}=1}until%f==8;$\=$/;$,=$";print sort{$a<=>$b}keys%f
