#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 334 Task 1  Range Sum
#=============================================================================
# You are given a list integers and pair of indices. Write a script
# to return the sum of integers between the given indices (inclusive).
# Example 1 Input: @ints = (-2, 0, 3, -5, 2, -1), $x = 0, $y = 2
#           Output: 1
# Example 2 Input: @ints = (1, -2, 3, -4, 5), $x = 1, $y = 3
#           Output: -3
# Example 3 Input: @ints = (1, 0, 2, -1, 3), $x = 3, $y = 4
#           Output: 2
# Example 4 Input: @ints = (-5, 4, -3, 2, -1, 0), $x = 0, $y = 3
#           Output: -2
# Example 5 Input: @ints = (-1, 0, 2, -3, -2, 1), $x = 0, $y = 2
#           Output: 1
#=============================================================================

use v5.42;


use Getopt::Long;
my $DoTest  = false;

my $X;
my $Y;

GetOptions("test" => \$DoTest, "x:i" => \$X, "y:i" => \$Y);
my $logger;
{
    use Log::Log4perl qw(:easy);
    Log::Log4perl->easy_init({ level => $DEBUG,
            layout => "%d{HH:mm:ss.SSS} %p{1} %m%n" });
    $logger = Log::Log4perl->get_logger();
}
#=============================================================================

exit(!runTest()) if $DoTest;

$X //= 0;
$Y //= $#ARGV;
say rangeSum($X, $Y, \@ARGV);

#=============================================================================
sub rangeSum($x, $y, $ints)
{
    use List::Util qw/sum0/;
    if ( $x > $y ) { ($x, $y) = ($y, $x) }

    return sum0 map { $_ // 0 } $ints->@[$x .. $y];
}

sub runTest
{
    use Test2::V0;

    is( rangeSum(0,2, [-2, 0, 3, -5, 2, -1] ), 1, "Example 1");
    is( rangeSum(1,3, [1,-2,3,-4,,5       ] ), -3, "Example 2");
    is( rangeSum(3,4, [1,0,2,-1,3         ] ), 2, "Example 3");
    is( rangeSum(0,3, [-5,4,-3,2,-1,0     ] ), -2, "Example 4");
    is( rangeSum(0,2, [-1,0,3,-3,-2,1     ] ), 2, "Example 5");

    is( rangeSum(0,0, [ 9,0,3,-3,-2,1     ] ),  9, "Singleton");
    is( rangeSum(1,9, [ 0                 ] ),  0, "Out of range");
    is( rangeSum(1,9, [ 0,1,2,3           ] ),  6, "Partial range");
    is( rangeSum(3,2, [ 0,1,2,3           ] ),  5, "Backwards?");

    done_testing;
}
