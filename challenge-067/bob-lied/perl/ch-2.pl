#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
#  
# ch-2.pl Perl Weekly Challenge 067 Task 2 Gray Code Sequence
#=============================================================================
# You are given an integer 2 <= $N <= 5.
# Write a script to generate $N-bit gray code sequence.
# https://en.wikipedia.org/wiki/Gray_code
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

say join(" ", gcs(shift)->@*) while @ARGV;

#=============================================================================
sub gcs($n)
{
    my @g = (0,1);
    my $one = 0x1;
    while ( --$n )
    {
        $one <<= 1;
        @g = ( @g, map { $one|$_ } reverse(@g) );
    }
    return \@g;
}

sub runTest
{
    use Test2::V0;

    is( gcs(1), [0,1], "N=1");
    is( gcs(2), [0,1,3,2], "N=2");
    is( gcs(3), [0,1,3,2,6,7,5,4], "N=3");
    is( gcs(4), [0,1,3,2,6,7,5,4,12,13,15,14,10,11,9,8], "N=4");
    is( gcs(5), [0,1,3,2,6,7,5,4,12,13,15,14,10,11,9,8,
                 24,25,27,26,30,31,29,28,20,21,23,22,18,19,17,16] , "N=5");

    done_testing;
}
