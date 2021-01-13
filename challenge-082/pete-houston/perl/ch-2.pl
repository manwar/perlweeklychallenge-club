#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 8202.pl
#
#        USAGE: ./8202.pl substr1 substr2 str
#
#  DESCRIPTION: Report if str can be made by "interleaving" the substrs
#
#        NOTES: Prints 1 if the string can be made, otherwise 0
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 17/10/20
#===============================================================================

use strict;
use warnings;

my @sub = @ARGV;
my $str = pop @sub;

# No point going further if this basic test fails
nope () if length ($str) ne length ($sub[0] . $sub[1]);

# Try tucking first substring into second, then vice-versa
for my $i (0, 1) {
	my $j = 1 - $i;
	my $jpos = index ($str, $sub[$j]);
	while ($jpos > -1) {
		# $sub[$j] is contained within $str, so strip it and see if we
		# are left with $sub[$i]
		my $copy = $str;
		substr ($copy, $jpos, length ($sub[$j]), '');
		yep () if $copy eq $sub[$i];
		# No joy, so keep looking
		$jpos = index ($str, $sub[$j], $jpos + 1);
	}
}
nope ();

sub yep {
	print "1\n";
	exit;
}

sub nope {
	print "0\n";
	exit;
}
