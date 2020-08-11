#!/usr/bin/env perl

# 031-1
# Create a function to check divide by zero error without checking if the
# denominator is zero.

use 5.030;
use strict;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

sub divide ($num, $denom) {
  my $result = eval { $num / $denom };
  warn "($num / $denom) $@" and return undef if
    $@ && index($@, 'Illegal division by zero') > -1;
  return $result;
}

sub print_div ($num, $denom) {
  my $result = divide $num, $denom;
  say "$num / $denom = ", ($result // 'ERROR');
}

my @tests = (
  [ 5, 2 ],
  [ 1, 0 ],
  [ 99, 999999 ],
  [ -1.5, 2 ],
  [ -2, -99999 ],
  [ 0, 19.991 ],
  [ 0.123, 0 ],
  [ 9999999999, 0 ],
  [ 256, 8 ],
);

print_div @$_ for @tests;


__DATA__
# Output:

(1 / 0) Illegal division by zero at ch-1.pl line 14.
(0.123 / 0) Illegal division by zero at ch-1.pl line 14.
(9999999999 / 0) Illegal division by zero at ch-1.pl line 14.
5 / 2 = 2.5
1 / 0 = ERROR
99 / 999999 = 9.9000099000099e-05
-1.5 / 2 = -0.75
-2 / -99999 = 2.0000200002e-05
0 / 19.991 = 0
0.123 / 0 = ERROR
9999999999 / 0 = ERROR
256 / 8 = 32

