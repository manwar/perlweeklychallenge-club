#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Time::HiRes qw(time);

my($count,$t0,$pr,@primes) = (10,time,3,2,3);
my $pad0 = my $pad1 = my $pad2 = 1;

## Minor "buglet" in the loop is the first two values 2 & 3
## do not appear in the output (this is due to them being less
## than the square of the maximum value of the primes array,
## so we just output them...

$count--, say sprintf '%11.6f %20d', -$t0+($t0=time), $_ for @primes;

T: while($count) {

  ## Update padovan number...

  ( $pad0, $pad1, $pad2 ) = ( $pad1, $pad2, $pad0+$pad1 );

  ## Skip early duplicates...

  next if $pad2 == $pad1;

  ## Extend our prime array if required

  O: for( ; $primes[-1]*$primes[-1] < $pad2; $pr += 2) {
    $_*$_ > $pad2 ? last : $pr % $_ || next O for @primes;
    push @primes, $pr;
  }

  ## Now check for prime factors, if we find one we bomb
  ## out! It doesn't matter than we compute more primes
  ## than we need for composite numbers as we will need
  ## them for the next padovan prime....

  $pad2 % $_ || next T for @primes;

  say sprintf '%11.6f %20d', -$t0+($t0=time), $pad2;

  $count--;
}

