#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 13402.pl
#
#        USAGE: ./13402.pl ROWS COLUMNS 
#
#  DESCRIPTION: Multiplication table and count of distinct products
#
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 11/10/21
#===============================================================================

use strict;
use warnings;

my ($r, $c) = @ARGV;

my $maxlenp = length ($r * $c) + 1;
my $maxlenr = length ($r);

my $ifmt = "%${maxlenp}i";
my $rfmt = "%${maxlenr}i";

my $row;
$row .= sprintf $ifmt, $_ for 1 .. $c;
printf "%${maxlenr}s | %s\n", 'x', $row;

print (('-' x ${maxlenr}) . '-+-' . ('-' x ($maxlenp * $c)) . "\n");

my %seen;
for my $i (1 .. $r) {
	my @rval = map { $_ *= $i } 1 .. $c;
	@seen{@rval} = (1) x $r;
	$row = '';
	$row .= sprintf $ifmt, $_ for @rval;
	printf "$rfmt | %s\n", $i, $row;
}
print "\nDistinct Terms: " . join (', ', sort { $a <=> $b } keys %seen) . "\n";
print "Count: " . keys (%seen) . "\n";
