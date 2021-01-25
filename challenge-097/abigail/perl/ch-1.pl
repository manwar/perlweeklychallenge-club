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
# Run as: perl ch-1.pl < input-file
#

while (<>) {
    chomp;
    my ($times, $plain) = split ' ', $_, 2;
    $times %= 26;
    $plain =~ y/A-Z/ZA-Y/ for 1 .. $times;
    say $plain;
}
