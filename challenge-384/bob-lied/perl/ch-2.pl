#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 384 Task 2  Special Binary Substrings
#=============================================================================
# You are given a binary string.  Write a script to return all non-empty
# substrings (distinct) that have the same number of 0’s and 1’s, and all
# the 0’s and all the 1’s in these substrings are grouped consecutively.
# Example 1 Input: $binary = "0101"
#           Output: ("01", "10", "01")
# Example 2 Input: $binary = "000111"
#           Output: ("000111", "0011", "01")
# Example 3 Input: $binary = "000011"
#           Output:  ("0011", "01")
# Example 4 Input: $binary = "10011100"
#           Output: ("10", "0011", "01", "1100", "10")
# Example 5 Input: $binary = "00000"
#           Output: ()
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
    say '(', join(", ", map { qq("$_") } task($_)->@*), ')';
}

#=============================================================================
sub task($binary)
{
    my @out = ();

    # Extract runs of 0s and 1s. They will alternate
    my @run = ( $binary =~ m/(0+|1+)/g );

    # Move through the list in pairs. Could use List::MoreUtils::slideatatime.
    for ( my $first = shift @run
        ; defined(my $second = shift @run)
        ; $first = $second )
    {
        my $other;    # Work on a copy in case it gets shortened

        # Reduce strings to be of same size.
        my $length = length($first);
        if ( $length < length($second) )
        {
            $other = substr($second, 0, $length);
        }
        else
        {
            $length = length($second);
            $first = substr($first, 0, $length);
            $other = $second;
        }

        push @out, "$first$other";
        while ( --$length )
        {
            push @out, substr($first, 0, $length) . substr($other, 0, $length);
        }
    }

    return \@out;
}

sub runTest
{
    use Test2::V1 -ipP;

    is( task(    "0101"), ["01", "10", "01"],                 "Example 1");
    is( task(  "000111"), ["000111", "0011", "01"],           "Example 2");
    is( task(  "000011"), ["0011", "01"],                     "Example 3");
    is( task("10011100"), ["10", "0011", "01", "1100", "10"], "Example 4");
    is( task(   "00000"), [],                                 "Example 5");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
