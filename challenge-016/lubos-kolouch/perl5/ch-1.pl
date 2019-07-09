#!/usr/bin/perl 
#===============================================================================
#
#         FILE: 2019_16_1.pl
#
#        USAGE: ./2019_65_1.pl
#
#  DESCRIPTION: Perl Weekly challenge w16 #1
#
#               At a party a pie is to be shared by 100 guest. The first guest gets 1% of the pie, the second guest gets 2% of the remaining pie, the third gets 3% of the remaining pie, the fourth gets 4% and so on.
#
#               Write a script that figures out which guest gets the largest piece of pie.
#               Write a script to generate first 10 strong and weak prime numbers.
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

my $pie_left    = 1;
my $max_portion = 0;

sub get_portion {
    my $pie = shift;
    my $n   = shift;

    return $pie * $n / 100;
}

for my $n (1..100) {

    my $portion = get_portion( $pie_left, $n );

    if ( $portion < $max_portion ) {
        $n--;
        say 'Biggest portion has guest '. $n .' , portion size '.sprintf("%.2f%%\n",$max_portion*100);
        last;
    }

    $max_portion = $portion;
    $pie_left -= $portion;
}

use Test::More;

is( get_portion( 1, 1 ), 0.01, 'test if rest 1 == 0.01' );
is( get_portion( 2, 99 / 100 ), 99 / 100 * 2 / 100, 'test if rest 2 == 0.02*99' );

done_testing();
