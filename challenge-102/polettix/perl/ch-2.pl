#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

sub hash_counting_string ($N) {
   my $retval = '';
   ($retval, $N) = ("$N#$retval", $N - 1 - length $N) while $N > 1;
   return $N == 1 ? "#$retval" : $retval;
}

my $n = shift || 10;
say hash_counting_string($n);
