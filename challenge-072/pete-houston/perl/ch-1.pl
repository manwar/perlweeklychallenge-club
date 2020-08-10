#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 7201.pl
#
#        USAGE: ./7201.pl N [ N ... ]
#
#  DESCRIPTION: Given a whole number N display the number of trailing
#               zeros in N!
#
# REQUIREMENTS: Math::GMP, Params::Util, Lingua::EN::Inflexion
#        NOTES: Unclever but effective. The task was up to N = 10 but
#               this seems good for any arbitrary N thanks to Math::GMP.
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 03/08/20
#===============================================================================

use strict;
use warnings;
use Math::GMP;
use Params::Util '_POSINT';
use Lingua::EN::Inflexion;

for my $n (@ARGV) {
	next unless _POSINT ($n);
	my $z =()= Math::GMP->new($n)->bfac =~ /0(?=0*$)/g;
	print inflect ("$n! has <#n:$z> trailing <N:zero>\n");
}
