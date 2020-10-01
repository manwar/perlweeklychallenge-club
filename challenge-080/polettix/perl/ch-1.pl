#!/usr/bin/env perl
use 5.024;
use warnings;
use English qw< -no_match_vars >;
use experimental qw< postderef >;
no warnings qw< experimental::postderef >;

sub spnb {
   my @Np = (0, sort(grep { $_ > 0 } @_));
   push @Np, $Np[-1] + 2;
   (($Np[$_] + 1 < $Np[$_ + 1]) && return $Np[$_] + 1) for 0 .. $#Np - 1;
}

for my $test (
   [ 5, 2, -2, 0 ],
   [ 1, 8, -1 ],
   [2, 0, -1 ],
   [],
   [1, 2, 3],
   ) {
   say spnb($test->@*);
}
