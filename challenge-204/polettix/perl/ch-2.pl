#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';
use Data::Dumper;

my $reshaped = reshape_matrix([ [ 1 .. 3], [ 4 .. 6] ], 3, 2);
say $reshaped ? Dumper($reshaped) : 0;

sub reshape_matrix ($matrix, $r, $c) {
   my $needed = $r * $c;
   my $available = $matrix->@*;
   $available *= $matrix->[0]->@* if $available;
   return 0 if $needed != $available;

   my $it = elements_it($matrix);
   return [ map { [ map { $it->() } 1 .. $c ] } 1 .. $r ];
}

sub elements_it ($aoa) {
   my ($r, $c) = (0, 0);
   return sub {
      while ('necessary') {
         return if $r > $aoa->$#*;
         my $row = $aoa->[$r];
         if ($c > $row->$#*) {
            ++$r;
            $c = 0;
            next;
         }
         return $row->[$c++];
      }
   };
}
