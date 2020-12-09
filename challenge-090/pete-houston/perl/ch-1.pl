#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 9001.pl
#
#        USAGE: ./9001.pl STRING
#
#  DESCRIPTION: DNA nucleobase counts and complementary sequence
#
#        NOTES: STRING must contain uppercase A, C, G and T characters
#         BUGS: uses string eval *shudder*
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 07/12/20
#===============================================================================

use strict;
use warnings;

my $dna = shift;
for my $base (qw/A C G T/) {
	printf "Count of $base is %i\n", eval "\$dna =~ tr/$base/$base/;";
}
print "Original sequence is $dna\n";
$dna =~ tr/ACGT/TGCA/;
print "Complementary sequence is $dna\n";
