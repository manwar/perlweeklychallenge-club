#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 254 Task 1 Three Power
#=============================================================================
# You are given a positive integer, $n. Write a script to return true if
# the given integer is a power of three otherwise return false.
# Example 1 Input: $n = 27 Output: true
# Example 2 Input: $n = 0 Output: true
# Example 3 Input: $n = 6 Output: false
#=============================================================================

use v5.38;

use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say isPof3(shift) ? "true" : "false";

sub isPof3($n)
{
    if ( $n > 0  )    { $n /= 3  while ( $n % 3 == 0 );
                        return $n == 1;
                      }
    elsif ( $n == 0 ) { return true }
    else              { return false; }
}

sub runTest
{
    use Test2::V0;
    use builtin qw/true false/; no warnings "experimental::builtin";

    is( isPof3(27), true,  "Example 1");
    is( isPof3( 0), true,  "Example 2");
    is( isPof3( 6), false, "Example 3");

    my $p3 = Power->new(base => 3);
    is( $p3->isPowerOf(27), true,  "Example 1 with class");
    is( $p3->isPowerOf( 0), true,  "Example 2 with class");
    is( $p3->isPowerOf( 6), false, "Example 3 with class");

    done_testing;
}

use feature "class"; no warnings "experimental::class";

class Power
{
    field $base :param = 10;

    method isPowerOf($n) {
        if ( $n > 0  )    { $n /= $base  while ( $n % $base == 0 );
            return $n == 1;
        }
        elsif ( $n == 0 ) { return true }
        else              { return false; }
    }
}
