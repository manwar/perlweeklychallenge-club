#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 305 Task 1 Binary Prefix
#=============================================================================
# You are given a binary array.
# Write a script to return an array of booleans where the partial
# binary number up to that point is prime.
# Example 1 Input: @binary = (1, 0, 1)
#           Output: (false, true, true)
#       1 = 1 => false, 10 = 2 => true, 101 = 5 => false
#
# Example 2 Input: @binary = (1, 1, 0)
#           Output: (false, true, false)
#       1 = 1 => false,  11 => 3 => true, 110 => 6 => false
#
# Example 3 Input: @binary = (1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1)
#           Output: (false, true, true, false, false, true, false, false,
#           false, false, false, false, false, false, false, false, false,
#           false, false, true)
#=============================================================================

use v5.40;

use Math::Prime::Util qw/is_prime/;
use List::Util qw/reductions/;

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

say '(', join(", ", map { $_ ? "true": "false" } binPrefix(@ARGV)->@*), ')';

#=============================================================================
sub binPrefix(@binary)
{
    my $n = shift @binary;
    my @isPrime = ( is_prime($n) == 2 );
    while ( defined(my $b = shift @binary) )
    {
        $n = $n * 2 + $b;
        push @isPrime, is_prime($n) == 2;
    }
    return \@isPrime;
}

sub binPrefix_reduce(@binary)
{
    return [ map { is_prime($_) == 2 } reductions { ($a<<1) + $b } @binary ]
}

sub runTest
{
    use Test2::V0;

    is( binPrefix(1,0,1), [false,true,true],  "Example 1");
    is( binPrefix(1,1,0), [false,true,false], "Example 2");
    is( binPrefix(1, 1, 1, 1, 0, 1, 0, 0, 0, 0,   1, 0, 1, 0, 0, 1, 0, 0, 0, 1),
        [ false,  true,  true, false, false,  true, false, false, false, false,
          false, false, false, false, false, false, false, false, false, true ],
        "Example 3");

    is( binPrefix_reduce(1,0,1), [false,true,true],  "Example 1");
    is( binPrefix_reduce(1,1,0), [false,true,false], "Example 2");
    is( binPrefix_reduce(1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1),
        [ false,  true,  true, false, false,  true, false, false, false, false,
          false, false, false, false, false, false, false, false, false, true ],
        "Example 3");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;
    my @binary = (1) x 64;

    cmpthese($repeat, {
            shift  => sub { binPrefix(@binary) },
            reduce => sub { binPrefix_reduce(@binary) },
        });
}
