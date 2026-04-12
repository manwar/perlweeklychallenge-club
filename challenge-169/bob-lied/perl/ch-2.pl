#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 169 Task 2 Achilles Numbers
#=============================================================================
# Write a script to generate first 20 Achilles Numbers.
# https://en.wikipedia.org/wiki/Achilles_number
#
# An Achilles number is a number that is powerful but imperfect (not a perfect
# power). Named after Achilles, a hero of the Trojan war, who was also powerful
# but imperfect.  A positive integer n is a powerful number if, for every prime
# factor p of n, p^2 is also a divisor.  A number is a perfect power if it has
# any integer roots (square root, cube root, etc.).
#
# For example 36 factors to (2, 2, 3, 3) - every prime factor (2, 3) also has
# its square as a divisor (4, 9). But 36 has an integer square root, 6, so the
# number is a perfect power.  But 72 factors to (2, 2, 2, 3, 3); it similarly
# has 4 and 9 as divisors, but it has no integer roots. This is an Achilles
# number.
# Output 72, 108, 200,  288,  392,  432,  500,  648,  675,  800,
#       864, 968, 972, 1125, 1152, 1323, 1352, 1372, 1568, 1800
#=============================================================================

use v5.42;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
my $logger;
{
    use Log::Log4perl qw(:easy);
    Log::Log4perl->easy_init({ level => ($Verbose ? $DEBUG : $INFO ),
            layout => "%d{HH:mm:ss.SSS} %p{1} %m%n" });
    $logger = Log::Log4perl->get_logger();
}
#=============================================================================

exit(!runTest()) if $DoTest;

say $_ for @ARGV;   # TODO command line processing here

#=============================================================================
sub achilles($count)
{
    use Math::Prime::Util qw/factor_exp is_power/;
    use List::Util qw/all/;

    my $have = 0;
    my @list = ( my $n = 72 ); # Smallest possible = 2^3 + 3^2 = 8 * 9 = 72

    while ( $have < $count )
    {
        $n++;

        # Returns pairs of prime factors and how many, 72 -> [ [2,3], [3,2] ]
        my @pn = factor_exp($n);

        my @exp = map { $_->[1] } @pn;  # Look at the repetition counts

        if ( ( all { $_ > 1 } @exp ) && ! is_power($n) )
        {
            push @list, $n;
            $have++;
        }
    }
    return \@list;
}

sub runTest
{
    use Test2::V0;

    my @ach = achilles(20)->@*;

    is( $ach[ 0],   72, "A( 0)");
    is( $ach[ 1],  108, "A( 1)");
    is( $ach[ 2],  200, "A( 2)");
    is( $ach[ 3],  288, "A( 3)");
    is( $ach[ 4],  392, "A( 4)");
    is( $ach[ 5],  432, "A( 5)");
    is( $ach[ 6],  500, "A( 6)");
    is( $ach[ 7],  648, "A( 7)");
    is( $ach[ 8],  675, "A( 8)");
    is( $ach[ 9],  800, "A( 0)");
    is( $ach[10],  864, "A(10)");
    is( $ach[11],  968, "A(11)");
    is( $ach[12],  972, "A(12)");
    is( $ach[13], 1125, "A(13)");
    is( $ach[14], 1152, "A(14)");
    is( $ach[15], 1323, "A(15)");
    is( $ach[16], 1352, "A(16)");
    is( $ach[17], 1372, "A(17)");
    is( $ach[18], 1568, "A(18)");
    is( $ach[19], 1800, "A(19)");

    done_testing;
}
