#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 358 Task 1  Max Str Value
#=============================================================================
# You are given an array of alphanumeric string, @strings.
# Write a script to find the max value of alphanumeric string in the given
# array. The numeric representation of the string, if it comprises of digits
# only otherwise length of the string.
# Example 1 Input: @strings = ("123", "45", "6")
#			Output: 123
# Example 2 Input: @strings = ("abc", "de", "fghi")
#			Output: 4
# Example 3 Input: @strings = ("0012", "99", "a1b2c")
#			Output: 99
# Example 4 Input: @strings = ("x", "10", "xyz", "007")
#			Output: 10
# Example 5 Input: @strings = ("hello123", "2026", "perl")
#			Output: 2026
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

say msv(@ARGV);

#=============================================================================
sub msv(@str)
{
    use List::Util qw/max/;
    return max map { $_ =~ /\D/ ? length($_) : 0+$_ } @str;
}

sub runTest
{
    use Test2::V0;

    is( msv("123", "45", "6"          ),  123, "Example 1");
    is( msv("abc", "de", "fghi"       ),    4, "Example 2");
    is( msv("0012", "99", "a1b2c"     ),   99, "Example 3");
    is( msv("x", "10", "xyz", "007"   ),   10, "Example 4");
    is( msv("hello123", "2026", "perl"), 2026, "Example 5");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
