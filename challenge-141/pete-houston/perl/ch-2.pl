#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 14102.pl
#
#        USAGE: ./14102.pl [ -v ] M N
#
#  DESCRIPTION: Give the count of numbers made from the digits of M in
#               order which are divisible by N
#
#      OPTIONS: -v gives verbose output
# REQUIREMENTS: Getopt::Long::Modern, Params::Util, List::MoreUtils
#         BUGS: Perhaps - see NOTES
#        NOTES: The spec is a bit loose with statements such as
#               "Repeating of digits are not allowed". Does this mean
#               input or output? I have taken it to mean just that an
#               input of 1234 will not allow 112 as a valid combo, which
#               seems reasonable. Similarly if 8888 is given as $m then
#               all the duplicated numbers are removed from the list (not
#               duplicated digits!) which should be just (8, 88, 888).
#
#               It also says "You are only allowed to use (n-1) digits
#               at the most" which I have taken to mean 1 fewer than the
#               total number of digits in $m. The use of "n" in that
#               statement is confusing but this seems to be the meaning
#               given the supplied examples.
#
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 03/12/21
#===============================================================================

use strict;
use warnings FATAL => 'all';
use Getopt::Long::Modern qw/:config pass_through/;
use Params::Util '_POSINT';
use List::MoreUtils 'uniq';

# Argument and option processing
GetOptions (
	'v' => \my $verbose
);
my ($m, $n) = @ARGV;

for ($m, $n) {
	die "'$_' is not a positive integer" unless _POSINT $_;
}
exit ! print "0\n" if $m < 10;

# Work with an array of digits
my @m    = split //, $m;

# Get all digit combinations in order
my @ints = uniq combos (@m);
print "All digit combinations of $m: @ints\n" if $verbose;

# Filter out the non-divisible and too-long values
@ints = grep { 0 == $_ % $n && $m ne $_ } @ints;
print "Filtered digit combinations: @ints\nResult count: " if $verbose;
print @ints . "\n";

sub combos {
	my (@x) = @_;

	# Return a list of the numbers formed from the digits of
	# @x in order.
	my @res = @x;    # all the single digit ones
	while ($#x > 0) { # Recurse for the multiple digit ones
		my $digit = shift @x;
		push @res, map {"$digit$_"} combos (@x);
	}
	return @res;
}
