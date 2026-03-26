#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 366 Task 2   Valid Times
#=============================================================================
# You are given a time in the form ‘HH:MM’. The earliest possible time is
# ‘00:00’ and the latest possible time is ‘23:59’. In the string time, the
# digits represented by the ‘?’ symbol are unknown, and must be replaced
# with a digit from 0 to 9.  Write a script to return the count different
# ways we can make it a valid time.
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

say validTime($_) for @ARGV;

#=============================================================================
sub validTime($time)
{
    state @hour   = '00' .. '23';
    state @minute = '00' .. '59';

    my ($h, $m) = map { s/\?/./gr } split(/:/, $time);

    return (grep /$h/, @hour) * (grep /$m/, @minute);
}

sub runTest
{
    use Test2::V0;

    my @version = ( { name => "solution", func => \&validTime } );

    my @case = (
        { desc => "Example 1", time => "?2:34", expect =>    3 },
        { desc => "Example 2", time => "?4:?0", expect =>   12 },
        { desc => "Example 3", time => "??:??", expect => 1440 },
        { desc => "Example 4", time => "?3:45", expect =>    3 },
        { desc => "Example 5", time => "2?:15", expect =>    4 },
        { desc => "Constant ", time => "09:30", expect =>    1 },
        { desc => "Minutes  ", time => "09:??", expect =>   60 },
        { desc => "Hours    ", time => "??:20", expect =>   24 },
        { desc => "Invalid  ", time => "24:20", expect =>    0 },
    );

    for my $v ( @version )
    {
        for my $c ( @case )
        {
            is( $v->{func}($c->{time}), $c->{expect}, "$v->{name} $c->{desc}");
        }
    }

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
