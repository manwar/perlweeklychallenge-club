#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 342 Task 2  Max Score
#=============================================================================
# You are given a string, $str, containing 0 and 1 only.
# Write a script to return the max score after splitting the string into two
# non-empty substrings. The score after splitting a string is the number of
# zeros in the left substring plus the number of ones in the right substring.
# Example 1 Input: $str = "0011"
#           Output: 4
#       left = "00", right = "11" => 2 + 2 => 4
# Example 2 Input: $str = "0000"
#           Output: 3
#       left = "000", right = "0" => 3 + 0 => 3
# Example 3 Input: $str = "1111"
#           Output: 3
#       left = "1", right = "111" => 0 + 3 => 3
# Example 4 Input: $str = "0101"
#           Output: 3
#        left = "0", right = "101" => 1 + 2 => 3
#        left = "010", right = "1" => 2 + 1 => 3
# Example 5 Input: $str = "011101"
#           Output: 5
#       left = "0", right = "11101" => 1 + 4 => 5
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

say score($_) for @ARGV;

#=============================================================================
sub score($str)
{
    use List::Util qw/sum/;
    my @b = split(//, $str);
    my $right = sum(@b) - $b[0];
    my $left = (shift(@b) == 0 ? 1 : 0);
    pop(@b);
    my $best = $left + $right;

    for ( @b )
    {
        if ( $_ ) { $right-- } else { $left++ }
        my $s = $left + $right;
        $best = $s if $s > $best;
    }
    return $best;
}

sub runTest
{
    use Test2::V0;

    is( score("0011"  ), 4, "Example 1");
    is( score("0000"  ), 3, "Example 2");
    is( score("1111"  ), 3, "Example 3");
    is( score("0101"  ), 3, "Example 4");
    is( score("011101"), 5, "Example 5");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
