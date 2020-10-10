#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 8102.pl
#
#        USAGE: ./8102.pl [ infile ] 
#
#  DESCRIPTION: Word frequencies
#
#      OPTIONS: Read data from STDIN if input filename is missing
# REQUIREMENTS: List::MoreUtils 0.42 or newer
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 05/10/20
#===============================================================================

use strict;
use warnings;

use List::MoreUtils 0.420 'occurrences';

# Optionally open the file
my $fh = \*STDIN;
if (defined $ARGV[0]) {
	open $fh, '<', $ARGV[0] or die "Cannot open $ARGV[0]: $!";
}

# Convert the input into an array of words
my @words;
while (<$fh>) {
	s/[."(),]|'s|--//g;
	push @words, split;
}

# Find and display the frequencies
my @occ = occurrences (@words);
for my $i (0 .. $#occ) {
	print "$i: " . join (' ', sort @{$occ[$i]}) . "\n" if defined $occ[$i];
}
