#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 8701.pl
#
#        USAGE: ./8701.pl N N [ ... ]
#
#  DESCRIPTION: Output longest sequence of incrementing integers
#
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 18/11/20
#===============================================================================

use strict;
use warnings;

my @n      = sort { $a <=> $b } @ARGV;
my @maxseq = 0;

for my $i (0 .. $#n - 1) {
	my $j = $i + 1;
	my @seq = $n[$i];
	while ($n[$j] == $n[$i] + $j - $i) {
		push @seq, $n[$j++];
		last if $j > $#n;
	} continue {
		@maxseq = @seq if $#seq > $#maxseq;
	}
}

print "@maxseq\n";
