#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 9601.pl
#
#        USAGE: ./9601.pl ( -t | STRING )
#
#  DESCRIPTION: Reverse the words in the given string, with canonical space.
#
#      OPTIONS: Use -t to run the tests, otherwise it will process the
#               given string.
# REQUIREMENTS: Perl 5.10.0, Test::More
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 18/01/21
#===============================================================================

use strict;
use warnings;
use 5.010; # for defined-or
use Test::More;

my $str = shift // die "Usage: $0 ( -t | STRING )\n";

if ($str eq '-t') {
	tests ();
} else {
	print revstr($str) . "\n";
}
exit;

sub revstr {
	return join ' ', reverse split ' ', shift;
}

sub tests {
	my @tests = (
		{
			in => 'The Weekly Challenge',
			want => 'Challenge Weekly The'
		},
		{
			in => '    Perl and   Raku are  part of the same family  ',
			want => 'family same the of part are Raku and Perl'
		},
	);

	plan tests => scalar @tests;
	for my $t (@tests) {
		is revstr ($t->{in}), $t->{want}, "'$t->{in}'";
	}
}
