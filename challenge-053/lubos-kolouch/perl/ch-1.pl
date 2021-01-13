#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl  
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-053/
#
#  Rotate Matrix
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Lubos Kolouch
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 03/26/2020 08:19:01 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use PDL;
use feature qw/say/;


# When researching this topic, I found:
# https://stackoverflow.com/questions/21433364/use-perl-pdl-to-rotate-a-matrix
# and then adapted it using e-choroba's slicing. 
#
# PDL seems very interesting!

my $m = sequence(3,3)+1;

print($m);

for (0..2) {
    say(90*($_+1));
    $m = $m->transpose->slice([-1,0]);
    print($m);
}

