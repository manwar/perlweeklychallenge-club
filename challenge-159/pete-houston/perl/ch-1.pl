#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 15901.pl
#
#        USAGE: ./15901.pl N 
#
#  DESCRIPTION: Print the Farey Sequence of order N
#
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 06/04/22
#===============================================================================

use strict;
use warnings;

my $n = shift;
die "Argument must be natural number.\n"
	unless defined ($n) && $n =~ /^[1-9][0-9]*$/;

# Initialise the sequence
my ($fn, $fd, $ln, $ld) = (0, 1, 1, $n);
my @seq = ("$fn/$fd", "$ln/$ld");

# Loop over the rest
while ($ln < $n) {
	my $x = int (($n + $fd) / $ld);
	($fn, $fd, $ln, $ld) = ($ln, $ld, $x * $ln - $fn, $x * $ld - $fd);
	push @seq, "$ln/$ld" if $ld >= $ln;
}

print "@seq\n";
