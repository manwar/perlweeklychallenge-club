#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Math::Prime::Util qw(factor gcd);
use Time::HiRes qw(time);

my $time = time;
open my $fh, '>', 'achilles.txt';

for( my( $n, $c, $MAX ) = ( 2, 0, @ARGV ? $ARGV[0] : 1e2 ); $c<$MAX; $n++ ) {
  my %factors;
  $factors{$_}++ foreach factor $n;
  say {$fh} sprintf '%6d: %15d - %s', ++$c, $n,
      join ' . ',
      map  { "$_^$factors{$_}" }
      sort { $a <=> $b }
      keys  %factors
    if 1 == gcd( grep { $_ < 2 ? next : 1 } values %factors )
    ## Any of the factors is not squared we try the next number in the loop!
}
close $fh;
warn 'Time taken: ', time-$time, "\n";

