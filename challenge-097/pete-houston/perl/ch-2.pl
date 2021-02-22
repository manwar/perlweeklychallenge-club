#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 9702.pl
#
#        USAGE: ./9702.pl STRING N 
#
#  DESCRIPTION: Minimum bit string flips for uniformity
#
# REQUIREMENTS: List::MoreUtils, List::Util
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 25/01/21
#===============================================================================

use strict;
use warnings;
use List::MoreUtils 'uniq';
use List::Util 'min';

my ($bstring, $len) = @ARGV;

# Divide up
my @strings = $bstring =~ /(.{$len})/g;

# Deduplicate
@strings = uniq @strings;

# Bail if no-op
exit print "0\n" if 1 == @strings;

my $minmoves = 0;

for my $pos (0 .. $len - 1) {
	# Count those digits!
	my %bits = ( 0 => 0, 1 => 0 );
	$bits{substr ($_, $pos, 1)}++ for @strings;
	$minmoves += min ($bits{0}, $bits{1});
}

print "$minmoves\n";
