#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 14801.pl
#
#        USAGE: ./14801.pl  
#
#  DESCRIPTION: Output all Eban Numbers <= 100
#
# REQUIREMENTS: Lingua::EN::Nums2Words, Lingua::EN::Inflexion
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 17/01/22
#===============================================================================

use strict;
use warnings;
use Lingua::EN::Nums2Words;
use Lingua::EN::Inflexion;

my @eban = grep { -1 == index num2word ($_), 'E' } 1 .. 100;
my $text = wordlist (@eban, {final_sep => ''});

print "The Eban numbers less than 101 are: $text.\n";
