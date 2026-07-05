#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 380 Task 1  Sum of Frequencies
#=============================================================================
# You are given a string consisting of English letters.  Write a script
# to find the vowel and consonant with maximum frequency. Return the sum
# of the two frequencies.
# Example 1 Input: $str = "banana"
#           Output: 5 (3 'a' + 2 'n')
# Example 2 Input: $str = "teestett"
#           Output: 7
# Example 3 Input: $str = "aeiouuaa"
#           Output: 3
# Example 4 Input: $str = "rhythm"
#           Output: 2
# Example 5 Input: $str = "x"
#           Output: 1
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

say task($_) for @ARGV;

#=============================================================================
sub task($str)
{
    $str =~ tr/a-zA-Z//dc;

    my %freq;
    my $maxV = my $maxC = 0;
    foreach ( split(//, lc $str) )
    {
        $freq{$_}++;
        if ( index('aeiou', $_) >= 0 )
        {
            $maxV = $freq{$_} if ( $freq{$_} > $maxV );
        }
        else
        {
            $maxC = $freq{$_} if ( $freq{$_} > $maxC );
        }
    }
    return $maxV + $maxC;
}

sub runTest
{
    use Test2::V0;

    is( task("banana"),   5, "Example 1");
    is( task("teestett"), 7, "Example 2");
    is( task("aeiouuaa"), 3, "Example 3");
    is( task("rhythm"),   2, "Example 4");
    is( task("x"),        1, "Example 5");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
