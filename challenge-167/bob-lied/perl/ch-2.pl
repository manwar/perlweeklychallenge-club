#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 167 Task 2  Gamma Function
#=============================================================================
# Implement subroutine gamma() using the Lanczos approximation method.
# https://en.wikipedia.org/wiki/Lanczos_approximation
# [2022-05-31] Ryan Thompson wrote an interesting blog explaining the
# subject in details. Highly recommended if you are looking for more information.
# https://ry.ca/2022/05/lanczos-approximation
# Example
#   gamma(3); # 1.99
#   gamma(5); # 24
#   gamma(7); # 719.99
#=============================================================================
#=============================================================================

use v5.44;


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
sub gamma($n)
{
    return 0;
}

sub runTest
{
    use Test2::V1 -ipP;

    is( task(3),   1.99, "gamma(3)");
    is( task(5),  24,    "gamma(5)");
    is( task(7), 719.99, "gamma(7)");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}

