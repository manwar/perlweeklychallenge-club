#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 303 Task 1 3-digits Even
#=============================================================================
# You are given a list (3 or more) of positive integers, @ints.
# Write a script to return all even 3-digits integers that can be formed
# using the integers in the given list.
# Example 1 Input: @ints = (2, 1, 3, 0)
#           Output: (102, 120, 130, 132, 210, 230, 302, 310, 312, 320)
# Example 2 Input: @ints = (2, 2, 8, 8, 2)
#           Output: (222, 228, 282, 288, 822, 828, 882)
#=============================================================================

use v5.40;
use Algorithm::Combinatorics qw/variations/;

use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);

my $logger;
{
    use Log::Log4perl qw(:easy);
    Log::Log4perl->easy_init({level => ($Verbose ? $DEBUG : $INFO),
                              layout => "%d{HH:mm:ss.SSS} %p{1} %m%n" });
    $logger = Log::Log4perl->get_logger();
}

#=============================================================================

exit(!runTest()) if $DoTest;

say "(", join(",", even3(@ARGV)), ")";

#=============================================================================
sub even3(@ints)
{
    return () if @ints < 3;
    my %evenCombo = ();
    my $combIter = variations(\@ints, 3);
    while ( my $comb = $combIter->next() )
    {
        $logger->debug("Try combo $comb->@*");
        if ( $comb->[-1] % 2 == 0 && $comb->[0] != 0 )
        {
            my $n = join("", $comb->@*);
            $evenCombo{$n} = $n;
            $logger->debug("\tis even $n");
        }
    }
    return keys %evenCombo;
}

sub runTest
{
    use Test2::V0;

    is( [ sort ( even3(2,1,3,0) ) ],
        [ sort ( 102, 120, 130, 132, 210, 230, 302, 310, 312, 320 ) ], "Example 1");
    is( [ sort ( even3(2,2,8,8,2) ) ],
        [ sort ( 222, 228, 282, 288, 822, 828, 882 ) ], "Example 2");

    done_testing;
}
