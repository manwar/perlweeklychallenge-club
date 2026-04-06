#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 367 Task 1  Max Odd Binary
#=============================================================================
# You are given a binary string that has at least one ‘1’.
# Write a script to rearrange the bits in such a way that the resulting
# binary number is the maximum odd binary number and return the resulting
# binary string. The resulting string can have leading zeros.
# Example 1 Input: $str = "1011" Output: "1101"
# Example 2 Input: $str = "100" Output: "001"
# Example 3 Input: $str = "111000" Output: "110001"
# Example 4 Input: $str = "0101" Output: "1001"
# Example 5 Input: $str = "1111" Output: "1111"
#=============================================================================

use v5.42;


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

for ( @ARGV )
{
    say "SORT:  ", mobSort($_);
    say "SPLIT: ", mobSplit($_);
}

#=============================================================================
sub mobSort($str)
{
    my @bits = sort { $b cmp $a } split(//, $str);
    push @bits, shift @bits;
    return join("", @bits);
}

sub mobSplit($str)
{
    my @bit = ( "", "" );
    $bit[$_] .= $_ for split //, $str;

    substr($bit[1], -1, 0, $bit[0]);
    return $bit[1];
}

sub mobCount($str)
{
    my $n = length($str);
    my $zero = ($str =~ tr/0/0/);

    return ("1" x ($n-$zero-1)) . ("0" x $zero) . ("1");
}

sub runTest
{
    use Test2::V0;

    is( mobSort(   "1011" ),   "1101", "Example 1");
    is( mobSort(    "100" ),    "001", "Example 2");
    is( mobSort( "111000" ), "110001", "Example 3");
    is( mobSort(   "0101" ),   "1001", "Example 4");
    is( mobSort(   "1111" ),   "1111", "Example 5");
    is( mobSort(      "1" ),      "1", "One bit");

    is( mobSplit(   "1011" ),   "1101", "Example 1");
    is( mobSplit(    "100" ),    "001", "Example 2");
    is( mobSplit( "111000" ), "110001", "Example 3");
    is( mobSplit(   "0101" ),   "1001", "Example 4");
    is( mobSplit(   "1111" ),   "1111", "Example 5");
    is( mobSplit(      "1" ),      "1", "One bit");

    is( mobCount(   "1011" ),   "1101", "Example 1");
    is( mobCount(    "100" ),    "001", "Example 2");
    is( mobCount( "111000" ), "110001", "Example 3");
    is( mobCount(   "0101" ),   "1001", "Example 4");
    is( mobCount(   "1111" ),   "1111", "Example 5");
    is( mobCount(      "1" ),      "1", "One bit");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    my $str = "10101010" x 5;

    cmpthese($repeat, {
            sorting   => sub { mobSort($str)  },
            splitting => sub { mobSplit($str) },
            counting  => sub { mobCount($str) },
        });
}
