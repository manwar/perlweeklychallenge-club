#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';

say '(', join(', ', persistence_sort(@ARGV)), ')';

sub persistence_sort (@int) {
   map { $_->[0] }
      sort { ($a->[1] <=> $b->[1]) || ($a->[0] <=> $b->[0]) }
      map { [ $_, persistence_for($_) ] }
      @int;
}

sub persistence_for ($v) {
   my $rounds = 0;
   my @digits = split m{}mxs, $v;
   while (@digits > 1) {
      ++$rounds;
      @digits = split m{}mxs, prod(@digits);
   }
   return $rounds;
}

sub prod (@ints) {
   my $retval = 1;
   for my $int (@ints) {
      $retval *= $int or return 0;
   }
   return $retval;
}
