#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 308 Task 2 Decode XOR
#=============================================================================
# You are given an encoded array and an initial integer.
# Write a script to find the original array that produced the given encoded
# array. It was encoded such that encoded[i] = orig[i] XOR orig[i + 1].
#
# Example 1 Input: @encoded = (1, 2, 3), $initial = 1
#           Output: (1, 0, 2, 1)
#   Encoded array created like below, if the original array was (1, 0, 2, 1)
#   $encoded[0] = (1 xor 0) = 1
#   $encoded[1] = (0 xor 2) = 2
#   $encoded[2] = (2 xor 1) = 3
# Example 2 Input: @encoded = (6, 2, 7, 3), $initial = 4
#           Output: (4, 2, 0, 7, 4)
#=============================================================================

use v5.40;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
my $logger;
{
    use Log::Log4perl qw(:easy);
    Log::Log4perl->easy_init({ level => ($Verbose ? $DEBUG : $INFO ),
            layout => "%d{HH:mm:ss.SSS} %p{1} %m%n" });
    $logger = Log::Log4perl->get_logger();
}
#=============================================================================

exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say decxor(@ARGV);

#=============================================================================
sub decxor($initial, @list)
{
    my @original = ( $initial );
    push @original, $_ ^= $original[-1] for (@list);

    return [ @original ];
}

sub runTest
{
    use Test2::V0;

    is( decxor(1,  1,2,3  ), [1,0,2,1  ], "Example 1");
    is( decxor(4,  6,2,7,3), [4,2,0,7,4], "Example 2");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
