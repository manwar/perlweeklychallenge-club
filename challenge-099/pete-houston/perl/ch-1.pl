#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 9901.pl
#
#        USAGE: ./9901.pl [ STRING GLOB ]
#
#  DESCRIPTION: Re-invent globbing but with just * and ?
#               Print 1 if GLOB matches STRING, 0 otherwise
#
#      OPTIONS: With no arguments, runs the test suite
# REQUIREMENTS: Test::More
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 08/02/21
#===============================================================================

use strict;
use warnings;
use Test::More;

my ($str, $pat) = @ARGV;

if (defined $str) {
	print valid_glob($str, $pat) . "\n";
	exit;
}

# Tests
my @good = (
	{ str => 'abcde', pat => 'a*e'   },
	{ str => 'abcde', pat => 'a*c?e' },
	{ str => 'abcde', pat => '?b*e'  },
);

my @bad = (
	{ str => 'abcde', pat => 'a*d'   },
	{ str => 'abcde', pat => '?b*d'  },
	{ str => 'abcde', pat => '*b?e'  },
	{ str => 'abcde', pat => 'a.c?e' },
);

plan tests => @good + @bad;

for my $t (@good) {
	ok valid_glob ($t->{str}, $t->{pat}),
		"Matched $t->{str} against $t->{pat}";
}

for my $t (@bad) {
	ok !valid_glob ($t->{str}, $t->{pat}),
		"No match for $t->{str} against $t->{pat}";
}

sub valid_glob {
	my ($str, $pat) = @_;
	$pat = quotemeta $pat;
	$pat =~ s/\\\*/.*/g;
	$pat =~ s/\\\?/./g;
	$pat = qr/^$pat$/;
	return $str =~ $pat;
}
