#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 341 Task 1  Broken Keyboard
#=============================================================================
# You are given a string containing English letters only and also you
# are given broken keys. Write a script to return the total words in the
# given sentence can be typed completely.
# Example 1 Input: $str = 'Hello World', @keys = ('d')
#           Output: 1
# Example 2 Input: $str = 'apple banana cherry', @keys = ('a', 'e')
#           Output: 0
# Example 3 Input: $str = 'Coding is fun', @keys = ()
#           Output: 3
# Example 4 Input: $str = 'The Weekly Challenge', @keys = ('a','b')
#           Output: 2
# Example 5 Input: $str = 'Perl and Python', @keys = ('p')
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

say $_ for @ARGV;   # TODO command line processing here

#=============================================================================
sub broken($str, @keys)
{
    my $re = '[' . join("", @keys) . ']';
    $re = '^$' if @keys == 0;
    scalar grep !/$re/i, split(" ", $str);
}

sub runTest
{
    use Test2::V0;

    my $str; my @keys;
    $str = 'Hello World', @keys = ('d');
    is( broken($str, @keys), 1, "Example 1");
    $str = 'apple banana cherry', @keys = ('a', 'e');
    is( broken($str, @keys), 0, "Example 2");
    $str = 'Coding is fun', @keys = ();
    is( broken($str, @keys), 3, "Example 3");
    $str = 'The Weekly Challenge', @keys = ('a','b');
    is( broken($str, @keys), 2, "Example 4");
    $str = 'Perl and Python', @keys = ('p');
    is( broken($str, @keys), 1, "Example 5");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
