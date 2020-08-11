#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-2.pl
#
#        USAGE: ./ch-2.pl
#
#  DESCRIPTION: Task #2
#
#  Task #2
#  Write a script to print the smallest pair of Amicable Numbers. For more information, please checkout wikipedia page.
#
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Lubos Kolouch,
# ORGANIZATION:
#      VERSION: 1.0
#      CREATED: 07/08/2019 08:48:27 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use feature qw{ say };
use Math::Prime::XS qw/is_prime/;
use utf8;

sub get_amicable {
    my $n = shift;

    # Thābit ibn Qurra theorem
    my $p = 3 * 2**( $n - 1 ) - 1;
    return 0 unless is_prime($p);

    my $q = 3 * 2**($n) - 1;
    return 0 unless is_prime($q);

    my $r = 9 * 2**( 2 * $n - 1 ) - 1;
    return 0 unless is_prime($r);

    return ( 2**($n) * $p * $q, 2**($n) * $r );
}

###### MAIN ######

# must start with n>1
my $candidate = 2;

while (1) {
    if ( my (@result) = get_amicable($candidate) ) {
        say 'Pair found: ' . join qq/,/, @result;
        last;
    }

    $candidate++;
}

###### TESTS ######

use Test::More;

my @got = get_amicable(2);
my @expected = ( 220, 284 );
is_deeply( \@got, \@expected, 'Test 2' );

@got      = get_amicable(3);
@expected = (0);
is_deeply( \@got, \@expected, 'Test 3' );

@got = get_amicable(4);
@expected = ( 17_296, 18_416 );
is_deeply( \@got, \@expected, 'Test 4' );

@got      = get_amicable(5);
@expected = (0);
is_deeply( \@got, \@expected, 'Test 5' );

done_testing;
