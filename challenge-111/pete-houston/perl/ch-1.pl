#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 11101.pl
#
#        USAGE: ./11101.pl [ -v ] TARGET [ INFILE ] 
#
#  DESCRIPTION: Is the TARGET number in the matrix, or not?
#
#      OPTIONS: Specify -v for verbose output
#               If INFILE is not provided, reads from STDIN
#        NOTES: The reported matching row and column are 1-based
#               Everything in the input file which is not an integer is
#               ignored.
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 04/05/21
#===============================================================================

use strict;
use warnings;

# Do we want verbose output (ie. say which element was matched)?
my $verbose = 0;
if ($ARGV[0] eq '-v') {
	$verbose++;
	shift;
}

# Which number are we searching for?
my $target = shift;

# Create a hashref keyed on the integers in the matrix for a very efficient
# search mechanism
my $ints = load_grid ($ARGV[0]);

if ($ints->{$target}) {
	print "1\n";
	print "Found at $ints->{$target}\n" if $verbose;
} else {
	print "0\n";
}

sub load_grid {
	my $fh = \*STDIN;
	if (defined $_[0]) {
		open $fh, '<', $_[0] or die "Cannot open $_[0]: $!";
	}

	my %input;
	for my $r (1 .. 5) {
		my @ints = (<$fh> =~ /(-?[0-9]+)/g);
		for my $c (1 .. 5) {
			$input{$ints[$c-1]} = "row $r, column $c";
		}
	}
	return \%input;
}

