#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-2.pl < input-file
#

while (<>) {
    foreach my $number (1 .. $_) {
        say $number % 15 == 0 ? "fizzbuzz"
          : $number %  5 == 0 ? "buzz"
          : $number %  3 == 0 ? "fizz"
          :                      $number
    }
}
