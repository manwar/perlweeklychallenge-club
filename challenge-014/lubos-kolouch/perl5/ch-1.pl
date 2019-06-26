#!/usr/bin/perl
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl
#
#  DESCRIPTION: Perl Weekly Challenge Week 14 # 1
#               https://perlweeklychallenge.org/blog/perl-weekly-challenge-014/
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Lubos Kolouch
# ORGANIZATION:
#      VERSION: 1.0
#      CREATED: 06/24/2019 12:43:09 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use feature qw /say/;

my $max = shift // die 'No required count passed';

# cache always the last result
my %pos_cache;
$pos_cache{0} = 0;

# store the final solution
my $solution = 0;

# current position
my $pos = 1;

# cache the last item
my $last = 0;

while ( $pos < $max ) {

    # defaults to 0, if not found in cache yet
    my $result = 0;

    # try to find the previous number in cache
    if ( $pos_cache{$last} ) {
        $result = $pos - $pos_cache{$last};
    }

    # store the result
    $solution .= ",$result";

    # cache the previous result
    $pos_cache{$last} = $pos;

    # update the last number seen
    $last = $result;
    $pos++;
}

say $solution;
