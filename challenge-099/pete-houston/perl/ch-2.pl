#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 9902.pl
#
#        USAGE: ./9902.pl STRING SUBSTRING  
#
#  DESCRIPTION: Display count of unique subsequences matching chars of
#               SUBSTRING in order within STRING
#
# REQUIREMENTS: Memoize
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 08/02/21
#===============================================================================

use strict;
use warnings;
use Memoize;

memoize ('count_seqs');
print count_seqs(@ARGV) . "\n";

sub count_seqs {
	my ($str, $sub) = @_;
	my $tot = 0;
	my $pos = index ($str, substr ($sub, 0, 1));
	my $len = 1 == length $sub;

	while ($pos > -1) {
		$tot += $len ?
			1 :
			count_seqs (substr ($str, $pos + 1), substr ($sub, 1));
		$pos = index ($str, substr ($sub, 0, 1), $pos + 1);
	}
	return $tot;
}
