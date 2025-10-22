#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 344 Task 1  Array Form Compute
#=============================================================================
# You are given an array of integers, @ints and an integer, $x.
# Write a script to add $x to the integer in the array-form.
# The array form of an integer is a digit-by-digit representation stored as
# an array, where the most significant digit is at the 0th index.
# Example 1 Input: @ints = (1, 2, 3, 4), $x = 12
#           Output: (1, 2, 4, 6)
#       1,2,3,4 ==> 1234     1234+12 = 1246 ==> 1,2,4,6
# Example 2 Input: @ints = (2, 7, 4), $x = 181
#           Output: (4, 5, 5)
# Example 3 Input: @ints = (9, 9, 9), $x = 1
#           Output: (1, 0, 0, 0)
# Example 4 Input: @ints = (1, 0, 0, 0, 0), $x = 9999
#           Output: (1, 9, 9, 9, 9)
# Example 5 Input: @ints = (0), $x = 1000
#           Output: (1, 0, 0, 0)
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

my $ADDEND  = pop @ARGV;
say '(' . join(", ", afc( \@ARGV, $ADDEND)->@*), ")";

#=============================================================================
sub afc($int, $x)
{
    return [ split(//, join("", $int->@*) + $x) ];
}

sub runTest
{
    use Test2::V0;

    is( afc([  1,2,3,4],    12), [  1,2,4,6], "Example 1");
    is( afc([    2,7,4],   181), [    4,5,5], "Example 2");
    is( afc([    9,9,9],     1), [  1,0,0,0], "Example 3");
    is( afc([1,0,0,0,0],  9999), [1,9,9,9,9], "Example 4");
    is( afc([        0],  1000), [  1,0,0,0], "Example 5");

    done_testing;
}
