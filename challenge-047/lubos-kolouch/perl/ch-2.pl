#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-2.pl
#
#        USAGE: ./ch-2.pl  
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-047/
#       
#               Gapful Number
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Lubos Kolouch 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 02/13/2020 09:17:13 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use feature qw/say/;

my $count = 0;
for (100..10000) {
    if ($_ % int(substr($_,0,1).substr($_,2,1)) == 0) {
        say;
        $count++;
        last if $count == 20;
    }
}

