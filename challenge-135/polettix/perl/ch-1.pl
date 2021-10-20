#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';
sub middle_three_digits ($x) {
   die "not an integer\n" unless $x =~ m{\A(?: 0 | -? [1-9]\d* )\z}mxs;
   $x = -$x if $x < 0;
   my $l = length $x;
   die "too short\n" if $l < 3;
   die "even number of digits\n" unless $l % 2;
   return substr $x, ($l - 3) / 2, 3;
}
say middle_three_digits(shift // 1234567);
