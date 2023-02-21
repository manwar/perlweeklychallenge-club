#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge Week 177 Task 2 Palindromic Prime Cyclops
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# Write a script to generate first 20 Palindromic Prime Cyclops Numbers.
# A cyclops number is a number with an odd number of digits that has a zero
# in the center only.
# Output
# 101, 16061, 31013, 35053, 38083, 73037, 74047, 91019, 94049,
# 1120211, 1150511, 1160611, 1180811, 1190911, 1250521, 1280821,
# 1360631, 1390931, 1490941, 1520251
#
# Build the possible palindromes and use a library to test for prime.
# Possible palindromes begin and end with odd numbers other than 5 (because prime).
# We only need to construct the string on one side of the zero; the other
# side is just that string reversed.
#
# Note that a single zero in the center eliminates primes like 1300031
#  
#=============================================================================

use v5.36;

use Math::Prime::Util qw/is_prime/;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say join(", ", palPrimCyc()->@* );

sub palPrimCyc($n = 20, $max=2_000_000)
{
    my $first = 1;      # Leading/trailing digit
    my $digitWidth = 0; # Number of digits between first and center 0
    my @ppcNumber = (); # Answers

    my $ppc = "0";
    my $count = 0;
    SEARCH: while ( $count < $n && $ppc <= $max )
    {
        for my $first (1,3,7,9)
        {
            # A useful quirk of the range operator:  a range like
            # "00" .. "04" will preserve the leading zero when the
            # numbers are presented as strings.
            my $beg = "0" x $digitWidth;
            my $end = "9" x $digitWidth;

            for ($beg .. $end) # Has leading zeroes in $_
            {
                # Because front looks like a number, quote it as a
                # string to preserve leading zeroes.
                my $front = "$first$_";

                # If this number ends in a 0, we would violate the
                # cyclops condition (a single 0 in the middle)
                next if substr($front, -1, 1) == "0";

                my $ppc = "$front" . "0" . reverse("$front");
                last SEARCH if $ppc > $max;
                if ( is_prime($ppc) )
                {
                    push @ppcNumber, $ppc;
                    last SEARCH if ++$count == $n;
                }
            }
        }
        $digitWidth++;
    }
    return \@ppcNumber;
}

sub runTest
{
    use Test2::V0;

    my @list = (      101,   16061,   31013,   35053,   38083,
                    73037,   74047,   91019,   94049, 1120211,
                  1150511, 1160611, 1180811, 1190911, 1250521,
                  1280821, 1360631, 1390931, 1490941, 1520251,
                  1550551, 1580851, 1630361, 1640461, 1660661, );

    is( palPrimCyc(1), [101],             "First one");
    is( palPrimCyc(2), [101, 16061],      "First two");
    is( palPrimCyc(20), [ @list[0..19] ], "First 20");
    is( palPrimCyc(25), \@list,           "First 25");

    done_testing;
}
