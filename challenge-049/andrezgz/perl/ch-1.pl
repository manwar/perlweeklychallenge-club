#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-049/
# Task #1
#
# Smallest Multiple
# Write a script to accept a positive number as command line argument and
# print the smallest multiple of the given number consists of digits 0 and 1.
#
#For example:
# For given number 55, the smallest multiple is 110 consisting of digits 0 and 1.

use strict;
use warnings;

my $n = shift or die "USAGE: $0 <positive number>";
die "The argument must be a positive number" unless ( $n =~ /\d+/ && $n > 0);

my $m = $n;
$m += $n while ($m !~ /^[01]+$/);
print $m;

__END__

./ch-1.pl 25
100

./ch-1.pl 9
111111111
