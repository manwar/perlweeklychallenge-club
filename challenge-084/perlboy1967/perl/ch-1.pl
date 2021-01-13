#!/usr/bin/perl

# Perl Weekly Challenge - 084
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-084/
#
# Task 1 - Reverse Integer
#
# Author: Niels 'PerlBoy' van Dijke

use 5.16.3; # Matching the CentOS 7 distro I'm using

use strict;
use warnings;

my ($N) = @ARGV;

die "Please give signed 32 bits integer (- 2^31 <= X <= 2^31 - 1)"
  unless ($N =~ m#^(([-]*)(\d{1,10}))$# and 
          $1 >= -2**31 and
          $1 <=  2**31-1 
  );

my $O = sprintf('%s%s', $2 eq '-' ? '' : '-', scalar reverse $3);

printf "Input: %d\n", $N;
printf "Output: %d\n", $O;

