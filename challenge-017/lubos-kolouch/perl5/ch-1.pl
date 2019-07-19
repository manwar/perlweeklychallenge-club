#!/usr/bin/perl 
#===============================================================================
#
#         FILE: 2019_17_1.pl
#
#        USAGE: ./2019_17_1.pl
#
#  DESCRIPTION: Perl Weekly challenge w17 #1
#
#  Create a script to demonstrate Ackermann function. The Ackermann function is defined as below, m and n are positive number:
#
#     A(m, n) = n + 1                  if m = 0
#     A(m, n) = A(m - 1, 1)            if m > 0 and n = 0
#     A(m, n) = A(m - 1, A(m, n - 1))  if m > 0 and n > 0
#
#
#
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Lubos Kolouch
# ORGANIZATION:
#      VERSION: 1.0
#     REVISION: ---
#===============================================================================

use warnings;
use strict;
use feature qw{ say };
use Getopt::Long;

#### ---- I do not like this solution too much as the recursion is too deep
#very quickly. Perhaps could be done better with some kind of memoization in
#the next revision

sub get_ack {
    my ( $m, $n ) = @_;

    # just copy the definition
    return $n + 1 if $m == 0;
    return get_ack( $m - 1, 1 ) if ( $m > 0 ) and ( $n == 0 );

    return get_ack( $m - 1, get_ack( $m, $n - 1 ) );
}

#### ---------- MAIN -----------

my $m;
my $n;

GetOptions('m=s' => \$m, 'n=s' => \$n) ;

say get_ack( $m, $n );

use Test::More;

is( get_ack( 1, 2 ), 4, 'test if ack 1,2 == 4' );
is( get_ack( 2, 1 ), 5, 'test if ack 2,1 == 5' );

isnt( get_ack( 1, 2 ), 9, 'test if ack 1,2 != 9' );
isnt( get_ack( 2, 1 ), 1, 'test if ack 2,1 != 1' );

done_testing();
