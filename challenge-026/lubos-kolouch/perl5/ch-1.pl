#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl
#
#  DESCRIPTION: Perl weekly challenge 26 #1
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

sub get_common_chars {
    my ( $word1, $word2 ) = @_;

    my $count = 0;
    for ( split //, $word1 ) {
        $count++ if $word2 =~ /$_/msx;
    }

    return $count;
}

die 'Usage: script word1 word2' unless @ARGV == 2;

say get_common_chars(@ARGV);

# TESTS
use Test::More;

is( get_common_chars( 'chancellor', 'chocolate' ), 8 );
is( get_common_chars( 'chancellor', 'chocolat' ),  7 );
is( get_common_chars( 'abcde',      'fghi' ),      0 );

done_testing;
