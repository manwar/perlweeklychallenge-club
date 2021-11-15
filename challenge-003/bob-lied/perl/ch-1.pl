#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl
#=============================================================================
# Copyright (c) 2021, Bob Lied
#=============================================================================
# Perl Weekly challenge Week 3, Challenge #1
# Create a script to generate 5-smooth numbers, whose prime divisors are less
# or equal to 5. They are also called Hamming/Regular/Ugly numbers. For more
# information, please check this wikipedia.
# "... numbers are called 5-smooth, because they can be characterized as
# having only 2, 3, or 5 as prime factors. ..."
#=============================================================================

use strict;
use warnings;
use v5.32;

use experimental qw/ signatures /;
no warnings "experimental::signatures";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
my $Max = shift;
$Max //= 100;

sub fiveSmooth($max)
{
    my @smoothNumbers;
    for ( my $mult2 = 1; $mult2 <= $max ; $mult2 *= 2 )
    {
        for ( my $mult3 = $mult2 ; $mult3 <= $max ; $mult3 *= 3 )
        {
            for ( my $mult5 = $mult3 ; $mult5 <= $max ; $mult5 *= 5 )
            {
                push @smoothNumbers, $mult5 unless $mult5 == 1;    # Not in order
            }
        }
    }
    return \@smoothNumbers;
}
exit(!runTest()) if $DoTest;
my $smoothList = fiveSmooth($Max);
say $_ foreach sort { $a <=> $b} @$smoothList;

sub runTest
{
    use Test::More;

    is_deeply( fiveSmooth( 2), [ 2 ], "max = 2");
    is_deeply( fiveSmooth( 3), [ 2, 3 ], "max = 3");
    is_deeply( fiveSmooth( 5), [ 2, 3, 4, 5 ], "max = 5");
    is_deeply( fiveSmooth(10), [ 2, 3, 4, 5, 6, 8, 9, 10  ], "max = 10");
    is_deeply( fiveSmooth(20), [ 2, 3, 4, 5, 6, 8, 9, 10, 12, 15, 16, 18, 20 ], "max = 20");

    done_testing;
}

