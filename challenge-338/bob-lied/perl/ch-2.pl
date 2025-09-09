#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 338 Task 2  Max Distance
#=============================================================================
# You are given two integer arrays, @arr1 and @arr2.  Write a script to
# find the maximum difference between any pair of values from both arrays.
# Example 1 Input: @arr1 = (4, 5, 7)
#                  @arr2 = (9, 1, 3, 4)
#           Output: 6
#   With element $arr1[0] = 4   | 4 - 9 | = 5
#                               | 4 - 1 | = 3
#                               | 4 - 3 | = 1
#                               | 4 - 4 | = 0
#           max distance = 5
#   With element $arr1[1] = 5   | 5 - 9 | = 4
#                               | 5 - 1 | = 4
#                               | 5 - 3 | = 2
#                               | 5 - 4 | = 1
#           max distance = 4
#   With element $arr1[2] = 7   | 7 - 9 | = 2
#                               | 7 - 1 | = 6
#                               | 7 - 3 | = 4
#                               | 7 - 4 | = 4
#           max distance = 6
#   max (5, 4, 6) = 6
#
# Example 2 Input: @arr1 = (2, 3, 5, 4)
#                  @arr2 = (3, 2, 5, 5, 8, 7)
#           Output: 6
# Example 3 Input: @arr1 = (2, 1, 11, 3)
#                  @arr2 = (2, 5, 10, 2)
#           Output: 9
# Example 4 Input: @arr1 = (1, 2, 3)
#                  @arr2 = (3, 2, 1)
#           Output: 2
# Example 5 Input: @arr1 = (1, 0, 2, 3)
#                  @arr2 = (5, 0)
#           Output: 5#
#
#                 min1                   max1
#                 +-------------------------+
# +--------+  +--------+  +--------+   +--------+   +--------+
# min2  max2  min2  max2  min2  max2   min2  max2   min1  max2


#=============================================================================

use v5.42;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
my $logger;
{
    use Log::Log4perl qw(:easy);
    Log::Log4perl->easy_init({ level => ($Verbose ? $DEBUG : $INFO ),
            layout => "%d{HH:mm:ss.SSS} %p{1} %m%n" });
    $logger = Log::Log4perl->get_logger();
}
#=============================================================================

exit(!runTest()) if $DoTest;

my @ARR1 = split(",", shift // "");
my @ARR2 = split(",", shift // "");
try {  say maxDist(\@ARR1, \@ARR2); }
catch ( $e ) { say STDERR "Problem: $e" }

#=============================================================================
sub maxDist($arr1, $arr2)
{
    use List::MoreUtils qw/minmax/;
    use List::Util qw/max/;
    
    die "ERROR empty array" if ( ! (@$arr1 && @$arr2) );

    my ($min1, $max1) = minmax($arr1->@*);
    my ($min2, $max2) = minmax($arr2->@*);

    return max( $max1-$min2, $max2-$min1 );
}

sub runTest
{
    use Test2::V0;

    my @arr1; my @arr2;
    @arr1 = (4, 5, 7);
    @arr2 = (9, 1, 3, 4);
    is( maxDist(\@arr1, \@arr2), 6, "Example 1");

    @arr1 = (2, 3, 5, 4);
    @arr2 = (3, 2, 5, 5, 8, 7);
    is( maxDist(\@arr1, \@arr2), 6, "Example 2");

    @arr1 = (2, 1, 11, 3);
    @arr2 = (2, 5, 10, 2);
    is( maxDist(\@arr1, \@arr2), 9, "Example 3");

    @arr1 = (1, 2, 3);
    @arr2 = (3, 2, 1);
    is( maxDist(\@arr1, \@arr2), 2, "Example 4");

    @arr1 = (1, 0, 2, 3);
    @arr2 = (5, 0);
    is( maxDist(\@arr1, \@arr2), 5, "Example 5");

    like( dies { maxDist([], []) }, qr/empty/i, "Empty arrays");

    done_testing;
}
