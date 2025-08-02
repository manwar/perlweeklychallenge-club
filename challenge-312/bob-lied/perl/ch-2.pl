#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 312 Task 2 Balls and Boxes
#=============================================================================
# There are $n balls of mixed colors: red, blue or green. They are all
# distributed in 10 boxes labelled 0-9.
# You are given a string describing the location of balls.
# Write a script to find the number of boxes containing all three colors.
# Return 0 if none found.
#
# Example 1 Input: $str = "G0B1R2R0B0"
#           Output: 1
#   The given string describes there are 5 balls as below:
#   Box 0: Green(G0), Red(R0), Blue(B0) => 3 balls
#   Box 1: Blue(B1) => 1 ball
#   Box 2: Red(R2) => 1 ball
#
# Example 2 Input: $str = "G1R3R6B3G6B1B6R1G3"
#           Output: 3
#   The given string describes there are 9 balls as below:
#   Box 1: Red(R1), Blue(B1), Green(G1) => 3 balls
#   Box 3: Red(R3), Blue(B3), Green(G3) => 3 balls
#   Box 6: Red(R6), Blue(B6), Green(G6) => 3 balls
#
# Example 3 Input: $str = "B3B2G1B3"
#           Output: 0
#   Box 1: Green(G1) => 1 ball
#   Box 2: Blue(B2)  => 1 ball
#   Box 3: Blue(B3)  => 2 balls
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

say ballBox($_) for @ARGV;

#=============================================================================
sub ballBox($str)
{
    my @box = ("") x 10;
    for my ($color, $b) (split(//, $str)) # As of 5.36, multiple values allowed
    {
        $box[$b] .= $color;
    }
    return scalar grep { /B/ && /G/ && /R/ } @box;
}

sub ballBox_idx($str)
{
    my @box = ("") x 10;
    for my ($color, $b) (split(//, $str)) # As of 5.36, multiple values allowed
    {
        $box[$b] .= $color;
    }
    return scalar grep { index($_, "G") >= 0 && index($_, "B") >= 0 && index($_, "R") >= 0 } @box;
}

sub ballBox_hash($str)
{
    my @box;
    for my ($color, $b) (split(//, $str))
    {
        $box[$b]{$color}++;
    }
    return scalar grep { $_->{G} && $_->{B} && $_->{R} } @box;

}

sub runTest
{
    use Test2::V0;

    is( ballBox("G0B1R2R0B0"),         1, "Example 1");
    is( ballBox("G1R3R6B3G6B1B6R1G3"), 3, "Example 2");
    is( ballBox("B3B2G1B3"),           0, "Example 3");

    is( ballBox_idx("G0B1R2R0B0"),         1, "Example 1 idx");
    is( ballBox_idx("G1R3R6B3G6B1B6R1G3"), 3, "Example 2 idx");
    is( ballBox_idx("B3B2G1B3"),           0, "Example 3 idx");

    is( ballBox_hash("G0B1R2R0B0"),         1, "Example 1 hash");
    is( ballBox_hash("G1R3R6B3G6B1B6R1G3"), 3, "Example 2 hash");
    is( ballBox_hash("B3B2G1B3"),           0, "Example 3 hash");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    my $str;
    foreach my $color ( qw(R G B ) )
    {
        $str .= $color . int(rand(10)) for 1 .. 25;
    }

    cmpthese($repeat, {
            grep  => sub { ballBox($str) },
            index => sub { ballBox_idx($str) },
            hash  => sub { ballBox_hash($str) },
        });
}
