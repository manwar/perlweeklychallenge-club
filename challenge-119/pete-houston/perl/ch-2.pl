#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 11902.pl
#
#        USAGE: ./11902.pl [-v] N
#
#  DESCRIPTION: Print the nth member of the increasing sequence with
#               only digits 1, 2 and 3 and no double 1s.
#
#      OPTIONS: -v will additionally list all values up to the Nth
# REQUIREMENTS: List::Util, Getopt::Std (both in core)
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 28/06/21
#===============================================================================

use strict;
use warnings;

use List::Util 'max';
use Getopt::Std 'getopts';

# Parse the command line options and args
my $verbose = 0;
{
	my %opts;
	getopts ('v', \%opts);
	$verbose++ if $opts{v};
}

my ($n) = $ARGV[0] =~ /^([0-9]+)$/ or die "Argument must be positive int\n";

# Loop through the sequence up to the Nth entry
my $x = 1;
for (2 .. $n) {
	print "$x\n" if $verbose;
	$x = next_seq ($x);
}
print "$x\n";

# Generate the next element of the sequence from the current one.
sub next_seq {
	my $cur = shift;

	# Handle the trivial case
	return $cur + 1 unless substr ($cur, -1) eq 3;

	# Find the last non-3 and increment from there
	my $loc = max rindex ($cur, 1), rindex ($cur, 2);

	if ($loc < 0) {
		# They're all threes, so replace them all with repetitions of
		# '21' and prepend with 1
		my $new = "1$cur";
		$new =~ s/33/21/g;
		$new =~ s/3$/2/;
		return $new;
	}

	# Increment the last non-3 and replace the 3s following it with the
	# minimal pattern which is '12121212...'
	my $lastnon3 = substr $cur, $loc, 1;
	my $new      = $cur;
	my $len      = length $cur;
	my $rstr     = $lastnon3 + 1 . string_fill ('12', $len - $loc - 1);

	substr $new, $loc, $len - $loc + 1, $rstr;

	return $new;
}

# Given a pattern to repeat and a length, return a string of precisely
# that length filled with the pattern.
sub string_fill {
	my ($pat, $len) = @_;
	my $lpat = length $pat;
	my $buf = $pat x ($len / $lpat);
	$buf .= substr ($pat, 0, $len % $lpat);
	return $buf;
}
