#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 349 Task 2  Meeting Point
#=============================================================================
# You are given instruction string made up of U (up), D (down), L (left)
# and R (right).  Write a script to return true if following the instruction,
# you meet the starting point (0,0).
# Example 1 Input: $path = "ULD"
#           Output: false
# (-1,1) <- (0,1)
#    v        ^
# (-1,0)    (0,0)
#
# Example 2 Input: $path = "ULDR"
#           Output: true
# (-1,1) <- (0,1)
#    |        ^
#    v        |
# (-1,0) -> (0,0)
#
# Example 3 Input: $path = "UUURRRDDD"
#           Output: false
# (0,3) -> (1,3) -> (2,3) -> (3,3)
#   ^                          v
# (0,2)                      (3,2)
#   ^                          v
# (0,1)                      (3,1)
#   ^                          v
# (0,0)                      (3,0)
#
# Example 4 Input: $path = "UURRRDDLLL"
#           Output: true
# (0,2) -> (1,2) -> (2,2) -> (3,2)
#   ^                          v
# (0,1)                      (3,1)
#   ^                          v
# (0,0) <- (1,0) <- (1,1) <- (3,0)
#
# Example 5 Input: $path = "RRUULLDDRRUU"
#           Output: true
# (0,2) <- (1,2) <- (2,2)
#   v                 ^
# (0,1)             (2,1)
#   v                 ^
# (0,0) -> (1,0) -> (2,1)
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

say '', (meet($_) ? "true" : "false") for @ARGV;

#=============================================================================
sub meet($path) # Doesn't work, fails Example 5
{
    my @m = map { scalar(()= $path =~ m/$_/g) } qw(U D L R);
    # The Ups must be offset by Downs, and Rights by Lefts
    return $m[0] == $m[1]  && $m[2] == $m[3];
}

sub meetComplex($path)
{
    use Math::Complex;

    state $origin = (0 + 0*i);
    state %move   = ( R => (1 + 0*i), L => (-1 +  0*i),
                      U => (0 + 1*i), D => ( 0 + -1*i), );

    my $place = $origin;
    for ( split(//, uc $path) )
    {
        $place += $move{$_};
        return true if $place == $origin;
    }
    return false;
}

sub runTest
{
    use Test2::V0;

    is( meet(         "ULD"), false, "Example 1");
    is( meet(        "ULDR"),  true, "Example 2");
    is( meet(   "UUURRRDDD"), false, "Example 3");
    is( meet(  "UURRRDDLLL"),  true, "Example 4");
    is( meet("RRUULLDDRRUU"), false, "Example 5");

    is( meetComplex(         "ULD"), false, "Example 1 C");
    is( meetComplex(        "ULDR"),  true, "Example 2 C");
    is( meetComplex(   "UUURRRDDD"), false, "Example 3 C");
    is( meetComplex(  "UURRRDDLLL"),  true, "Example 4 C");
    is( meetComplex("RRUULLDDRRUU"),  true, "Example 5 C");

    done_testing;
}
