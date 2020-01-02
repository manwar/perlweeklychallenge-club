#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-2.pl
#
#        USAGE: ./ch-2.pl  
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-041/
#
#  Write a script to display first 20 Leonardo Numbers.
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Lubos Kolouch
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 01/02/2020 02:33:02 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use Data::Dumper;

my @l = (1,1);

for (2..19) {
    $l[$_] = $l[$_-2] + $l[$_-1]+1;
}

warn Dumper @l;
