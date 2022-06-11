#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';
use List::Util 'sum';

say is_factorion(shift // 145) ? 1 : 0;

sub is_factorion ($n) {
   state $f = [ 1, 1, 2, 6, 24, 120, 720, 5040, 40320, 362880 ];
   $n == sum map { $f->[$_] } split m{}mxs, $n;
}


my $s = '';
while ('necessary') {
   $s .= '9';
   last if $s > sumfact($s);
}
my $max = sumfact($s);
say $s, ' ', $max;

for my $n (0 .. $max) {
   say $n if is_factorion($n);
}

sub sumfact ($n) {
   state $f = [ 1, 1, 2, 6, 24, 120, 720, 5040, 40320, 362880 ];
   sum map { $f->[$_] } split m{}mxs, $n;
}
