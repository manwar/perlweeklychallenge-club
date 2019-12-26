#!/usr/bin/env perl
#
# ch-2.pl - FizzBuzz "one-liner"
#
# 2019 Ryan Thompson <rjt@cpan.org>

use 5.010;

say !($_ % 15) ? 'fizzbuzz'
  : !($_ %  3) ? 'fizz'
  : !($_ %  5) ? 'buzz'
  :              $_ for 1..20;
