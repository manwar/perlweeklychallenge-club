#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 11801.pl
#
#        USAGE: ./11801.pl N
#
#  DESCRIPTION: Print 1 if the decimal natural number N is a palindrome
#               when written as binary, 0 otherwise.
#
# REQUIREMENTS: Bit::Manip
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 21/06/21
#===============================================================================

use strict;
use warnings;
use Bit::Manip 'bit_bin';

my ($n)   = shift =~ /^([1-9][0-9]*)$/ or die "Argument must be positive int\n";
my $bin   = bit_bin ($n);
my $ispal = reverse ($bin) eq $bin ? 1 : 0;

print "$ispal as binary representation of $n is $bin which is "
  . ($ispal ? '' : 'NOT ')
  . "a palindrome.\n";
