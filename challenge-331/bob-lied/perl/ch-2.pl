#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 331 Task 2  Buddy Strings
#=============================================================================
# You are given two strings, source and target.
# Write a script to find out if the given strings are Buddy Strings.
# If swapping of a letter in one string make them same as the other
# then they are `Buddy Strings`.
# Example 1 Input: $source = "fuck" $target = "fcuk"
#           Output: true
#   The swapping of 'u' with 'c' makes it buddy strings.
# 
# Example 2 Input: $source = "love" $target = "love"
#           Output: false
# Example 3 Input: $source = "fodo" $target = "food"
#           Output: true
# Example 4 Input: $source = "feed" $target = "feed"
#           Output: true
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

for my ($src, $targ) ( @ARGV )
{
    say (isBuddy($src, $targ) ? "true" : "false");
}

#=============================================================================

sub isBuddy($source, $target)
{
    return false if length($source) != length($target);

    my @s = split(//, $source);
    my @t = split(//, $target);

    for my $i ( 0 .. $#s - 1 )
    {
        for my $j ( $i+1 .. $#s )
        {
            if ( $s[$i] eq $t[$j] && $s[$j] eq $t[$i] )
            {
                # We have a swappable pair. Do the rest of the
                # strings match?
                my @src = @s;
                ( $src[$i], $src[$j] ) = ( $t[$i], $t[$j] );
                return true if "@src" eq "@t";
            }
        }
    }
    return false;
}

sub runTest
{
    use Test2::V0;

    is( isBuddy("fuck", "fcuk"),  true, "Example 1");
    is( isBuddy("love", "love"), false, "Example 2");
    is( isBuddy("fodo", "food"),  true, "Example 3");
    is( isBuddy("feed", "feed"),  true, "Example 4");

    is( isBuddy("hamster", "ramsteh"),  true, "Non-consecutive pair");
    is( isBuddy("short", "srohter"), false, "Different lengths");

    is( isBuddy("bcxxxb", "cbxxxb"), true, "Multiple possible pairs");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
