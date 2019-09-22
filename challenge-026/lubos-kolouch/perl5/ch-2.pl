#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-2.pl
#
#        USAGE: ./ch-2.pl
#
#  DESCRIPTION: Perl weekly challenge 26 #2
#  https://perlweeklychallenge.org/blog/perl-weekly-challenge-026/
#
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Lubos Kolouch
# ORGANIZATION:
#      VERSION: 1.0
#      CREATED: 09/22/2019 12:28:35 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use feature qw/say/;
use Math::Trig;    # mainly for Pi

sub get_mean {
    my @angles = @_;

    my ( $sin_sum, $cos_sum );

    $sin_sum += sin( deg2rad($_) ) for @angles;
    $cos_sum += cos( deg2rad($_) ) for @angles;

    return rad2deg( atan2( $sin_sum, $cos_sum ) );
}

die 'Usage: script angle1 angle2 ...' unless @ARGV >= 2;

say get_mean(@ARGV);

# TESTS
use Test::More;

is( get_mean( 0, 0, 90 ), 26.565051177078 );

done_testing;
