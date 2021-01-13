#!/usr/bin/env perl
#===============================================================================
#
#        FILE: ch7002.pl
#
#        USAGE: ./ch7002.pl N
#
#  DESCRIPTION: Gray code builder starting from N = 2
#
# REQUIREMENTS: Params::Util
#        NOTES: N to be between 2 and 5 but why stop there?
#      AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      CREATED: 20/07/20 23:16:00
#===============================================================================

use strict;
use warnings;
use Params::Util '_POSINT';

$"    = ', ';
my $i  = 2;
my @gc = (0, 1, 3, 2);
my $n  = shift;
die "Argument ($n) is not an integer greater than 1"
    unless _POSINT ($n) && $n >= $i;

while ($i < $n) {
    push @gc, map {$_ + 2**$i} reverse @gc;
    $i++;
}
print "$n-bit Gray code is @gc\n";


