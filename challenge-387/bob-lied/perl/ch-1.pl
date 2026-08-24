#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 387 Task 1  Rearrange Binary String
#=============================================================================
# You are given a binary string string.  Write a script to re-arrange the
# given binary string that all occurrences of “01” are simultaneously
# replaced with “10” until no occurrences of “01” exist. Finally return the
# total steps needed.
# Example 1 Input: $str = "111000"
#           Output: 0
# Example 2 Input: $str = "00011"
#           Output: 4
#   Step 1: "00101" Step 2: "01010" Step 3: "10100" Step 4: "11000"
# Example 3 Input: $str = "01011"
#           Output: 3
# Example 4 Input: $str = "010101"
#           Output: 3
# Example 5 Input: $str = "00001"
#           Output: 4
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
sub task($str)
{
    my $step = 0;
    $step++ while ( $str =~ s/01/10/g );
    return $step;
}

sub runTest
{
    use Test2::V1 -ipP;

    is( task("111000"), 0, "Example 1");
    is( task( "00011"), 4, "Example 2");
    is( task( "01011"), 3, "Example 3");
    is( task("010101"), 3, "Example 4");
    is( task( "00001"), 4, "Example 5");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
