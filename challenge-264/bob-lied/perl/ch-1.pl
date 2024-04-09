#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
#  
# ch-1.pl Perl Weekly Challenge 264 Task 1 Greatest English Letter
#=============================================================================
# You are given a string, $str, made up of only alphabetic characters
# [a..zA..Z].  Write a script to return the greatest english letter in
# the given string.  A letter is greatest if it occurs as lower and upper
# case. Also letter ‘b’ is greater than ‘a’ if ‘b’ appears after ‘a’ in
# the English alphabet.
# Example 1 Input: $str = 'PeRlwEeKLy'
#           Output: L
#   There are two letters E and L that appears as lower and upper.
#   The letter L appears after E, so the L is the greatest english letter.
# Example 2 Input: $str = 'ChaLlenge'
#           Output: L
# Example 3 Input: $str = 'The'
#           Output: ''
#=============================================================================

use v5.38;

use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub gle($str)
{
    use List::Util qw/first/;

    # Put all lower case letters before upper, in reverse order
    my @rts = sort { $b cmp $a } split(//, $str);

    # Return the first lower case character that also has an upper
    while ( defined(my $char = shift @rts) )
    {
        return uc($char) if $char eq lc($char) && first { $_ eq uc($char) } @rts;
    }
    return '';
}

sub runTest
{
    use Test2::V0;

    is( gle("PeRlwEeKLy"), 'L', "Example 1");
    is( gle("ChaLlenge" ), 'L', "Example 2");
    is( gle("The"       ),  '', "Example 3");

    done_testing;
}
