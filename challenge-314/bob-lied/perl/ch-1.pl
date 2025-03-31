#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 314 Task 1 Equal Strings
#=============================================================================
# You are given three strings. You are allowed to remove the rightmost
# character of a string to make all equals.
# Write a script to return the number of operations to make them equal,
# or otherwise -1.
# Example 1 Input: $s1 = "abc", $s2 = "abb", $s3 = "ab"
#           Output: 2
#   Operation 1: Delete "c" from the string "abc"
#   Operation 2: Delete "b" from the string "abb"
# Example 2 Input: $s1 = "ayz", $s2 = "cyz", $s3 = "xyz"
#           Output: -1
# Example 3 Input: $s1 = "yza", $s2 = "yzb", $s3 = "yzc"
#           Output: 3
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

say eqstr(@ARGV);

#=============================================================================
sub eqstr(@str)
{
    use List::Util qw/min any all/;

    # What is the shortest word?
    my $len = min map { length } @str;

    # Convert all strings to arrays of character, put into a table
    my @word = map { [ split(//, $_) ] } @str;

    # Erase a common prefix
    for ( 1 .. $len )
    {
        if ( all { $word[0][0] eq $word[$_][0] } 1 .. $#word )
        {
            shift @$_ for @word;
        }
    }

    # Count words that have one remaining character, or fail if more
    my $howMany = 0;
    for ( map { scalar(@$_) } @word )
    {
        return -1 if $_ > 1;
        $howMany++ if $_ == 1;
    }

    # Count the number of words that have exactly one character remaining
    return $howMany
}

sub runTest
{
    use Test2::V0;

    is( eqstr( qw/123 123 123/ ),  0, "All same");
    is( eqstr( qw/  a   a   a/ ),  0, "Single letter same");
    is( eqstr( qw/  a   b   a/ ),  3, "Single letter different - empty string common");

    is( eqstr( qw/abc abb ab / ),  2, "Example 1");
    is( eqstr( qw/ayz cyz xyz/ ), -1, "Example 2");
    is( eqstr( qw/yza yzb yzc/ ),  3, "Example 3");

    is( eqstr( qw/ kl klm kln/ ),  2, "Short word first");
    is( eqstr( qw/ kl klmnop kln/ ), -1, "Long word in list");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
