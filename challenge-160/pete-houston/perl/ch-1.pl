#!/usr/bin/env perl
#===============================================================================
#
#         FILE: 16001.pl
#
#        USAGE: ./16001.pl N
#
#  DESCRIPTION: Down to four. N should be a whole number.
#
# REQUIREMENTS: Lingua::EN::Nums2Words
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 13/04/22
#===============================================================================

use strict;
use warnings;
use Lingua::EN::Nums2Words;

my $magic = 4;
my $n     = shift;
my $word  = ucfirst lc num2word ($n);

until ($n == $magic) {
	$n = length $word;
	print "$word is ";
	$word = lc num2word ($n);
	print "$word, ";
}

print "$word is magic.\n";
