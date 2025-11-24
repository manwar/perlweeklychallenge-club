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
sub meet($path)
{
    # my %move;
    # $move{$_} =()= $path =~ m/$_/g for ( qw(U D L R) );
    # return $move{U} == $move{D}  &&  $move{R} == $move{L};

    my @m = map { scalar(()= $path =~ m/$_/g) } qw(U D L R);
    return $m[0] == $m[1]  && $m[2] == $m[3];
}

sub meetC($path)
{
    use Math::Complex;

    state $origin = Math::Complex->make(0,0);
    state %move = ( U => Math::Complex->make( 0,  1),
                    D => Math::Complex->make( 0, -1),
                    R => Math::Complex->make( 1,  0),
                    L => Math::Complex->make(-1,  0) );

    my $place = $origin;
    $place += $move{$_} for split(//, uc $path);

    return ($place == $origin ? true : false);
}

sub runTest
{
    use Test2::V0;

    is( meet(         "ULD"), false, "Example 1");
    is( meet(        "ULDR"),  true, "Example 2");
    is( meet(   "UUURRRDDD"), false, "Example 3");
    is( meet(  "UURRRDDLLL"),  true, "Example 4");
    is( meet("RRUULLDDRRUU"), false, "Example 5");

    is( meetC(         "ULD"), false, "Example 1 C");
    is( meetC(        "ULDR"),  true, "Example 2 C");
    is( meetC(   "UUURRRDDD"), false, "Example 3 C");
    is( meetC(  "UURRRDDLLL"),  true, "Example 4 C");
    is( meetC("RRUULLDDRRUU"), false, "Example 5 C");

    done_testing;
}
