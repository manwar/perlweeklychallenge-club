#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Math::Prime::Util qw(is_prime);

# We only keep the last 3 Padovan numbers as that is all we need
# to generate the next one... We use the variables $p,$q,$r for
# this..
# We use a little used perl construct here - `redo` which restarts
# the loop everytime we have a Padovan number which is composite
# with updating "$_" - so we get 10 results.

# "1-liner" solution...

my$p=my$q=my$r=1;
($p,$q,$r)=($q,$r,$p+$q),$r!=$q&&is_prime($r)?say$r:redo for 0..9;

# "expanded" solution...

$p=$q=$r=1;

for (0..9) {
  ($p,$q,$r) = ($q,$r,$p+$q);
  redo if     $r == $q;       ## skip (redo loop) if same as previous value
  redo unless is_prime($r);   ## skip (redo loop) if not prime
  say $r;                     ## output if we get here, $_ will get updated
}

