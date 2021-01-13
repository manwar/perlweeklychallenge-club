#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 7901.pl
#
#        USAGE: ./7901.pl N
#
#  DESCRIPTION: Given N as decimal, total the 1 bits in all the binary
#               numbers from 1 to N.
#
# REQUIREMENTS: Params::Util, Bit::Manip
#        NOTES: The modulo was specified in the task.
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 22/09/20
#===============================================================================

use strict;
use warnings;

use Params::Util '_POSINT';
use Bit::Manip 'bit_count';

my $n = shift;

# Validate
die "'$n' is not a natural number.\n" unless _POSINT ($n);

# Count the sum of the 1 bits
my $tot = 0;
$tot += bit_count ($target, 1) for (1 .. $n);

# Output
print $tot % 1000000007 . "\n";
