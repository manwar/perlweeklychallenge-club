#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 329 Task 1  Counter Integers
#=============================================================================
# You are given a string containing only lower case English letters and digits.
# Write a script to replace every non-digit character with a space and then
# return all the distinct integers left.
# Example 1 Input: $str = "the1weekly2challenge2"
#           Output: 1, 2
#   2 is appeared twice, so we count it one only.
# Example 2 Input: $str = "go21od1lu5c7k"
#           Output: 21, 1, 5, 7
# Example 3 Input: $str = "4p3e2r1l"
#           Output: 4, 3, 2, 1
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

say join(", ", count($_)->@*) for @ARGV;

#=============================================================================
sub count($str)
{
    # Preserve order while eliminating repeated elements
    my $order = 1;
    my %present;
    $present{$_} //= $order++ for ( my @ints = $str =~ m/\d+/g );

    return [ sort { $present{$a} <=> $present{$b} } keys %present ];
}

sub runTest
{
    use Test2::V0;

    is( count("the1weekly2challenge2"), [1,2],      "Example 1");
    is( count("go21od1lu5c7k"),         [21,1,5,7], "Example 2");
    is( count("4p3e2r1l"),              [4,3,2,1],  "Example 3");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
