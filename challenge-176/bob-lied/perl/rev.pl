#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# rev.pl
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# We need to reverse a number (e.g, 632 -> 236).  Which is faster: doing
# the math, or treating it as a string?
#=============================================================================

use v5.36;

use Benchmark qw/cmpthese/;

use Getopt::Long;
my $DoBenchmark = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "benchmark" => \$DoBenchmark);

if ( $DoBenchmark )
{
    cmpthese(-5, {
            numeric => sub {
                rev1($_) for 123400 .. 124500;
            },
            string  => sub {
                rev2($_) for 123400 .. 124500;
            },
            }
        );
}
exit(!runTest()) if $DoTest;

sub rev1($n)
{
    use integer;
    my $r = $n % 10;
    while ( $n = int($n/10)  )
    {
        $r = ($r * 10) + ($n % 10);
    }
    return $r;
}

sub rev2($n)
{
    (my $r = reverse("$n")) =~ s/^0+//;
    return $r;
}

sub runTest
{
    use Test2::V0;

    is( rev1(  2),         2, "Test 1");
    is( rev1( 20),         2, "Test 2");
    is( rev1(632),       236, "Test 3");
    is( rev1(495632), 236594, "Test 6");

    is( rev2(  2),         2, "Test 1");
    is( rev2( 20),         2, "Test 2");
    is( rev2(632),       236, "Test 3");
    is( rev2(495632), 236594, "Test 6");

    done_testing;
}

