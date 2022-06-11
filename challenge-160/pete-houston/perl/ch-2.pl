#!/usr/bin/env perl
#===============================================================================
#
#         FILE: 16002.pl
#
#        USAGE: ./16002.pl N [ N ... ]
#
#  DESCRIPTION: Find equilibrium index. Each N should be an integer.
#
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 13/04/22
#===============================================================================

use strict;
use warnings;

my @n = @ARGV;

my $presum = my $postsum = 0;
$postsum += $_ for @n;

for my $i (0 .. $#n) {
	$presum  += $n[$i - 1] if $i;
	$postsum -= $n[$i];
	if ($presum == $postsum) {
		print "$i\n";
		exit;
	}
}

print "-1\n";
