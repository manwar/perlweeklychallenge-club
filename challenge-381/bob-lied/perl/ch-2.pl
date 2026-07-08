#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 381 Task 2  Smaller Greater Element
#=============================================================================
# You are given an array of integers. Write a script to find the number of
# elements that have both a strictly smaller and greater element in the
# given array.
#=============================================================================

use v5.42;

use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
my $logger;
{
    use Log::Log4perl qw(:easy);
    Log::Log4perl->easy_init({ level => ($Verbose ? $DEBUG : $INFO ),
            layout => "%d{HH:mm:ss.SSS} %p{1} %m%n" });
    $logger = Log::Log4perl->get_logger();
}
#=============================================================================

exit(!runTest()) if $DoTest;

say task(@ARGV);

#=============================================================================
sub task(@int)
{
    use List::AllUtils qw/sum0 minmax/;
    my ($min, $max) = minmax(@int);

    return scalar grep { $min < $_ < $max } @int
}

sub runTest
{
    use Test2::V1 -ipP;

    is( task(2,4              ), 0, "Example 1");
    is( task(1,1,1,1          ), 0, "Example 2");
    is( task(1,1,4,8,12,12    ), 2, "Example 3");
    is( task(3,6,6,9          ), 2, "Example 4");
    is( task(0, -5, 10, -2, -4), 3, "Example 5");

    done_testing;
}
