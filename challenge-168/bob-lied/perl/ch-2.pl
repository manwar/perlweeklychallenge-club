#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 168 Task 2  Home Prime
#=============================================================================
# You are given an integer greater than 1.  Write a script to find the home
# prime of the given number.  In number theory, the home prime HP(n) of an
# integer n greater than 1 is the prime number obtained by repeatedly
# factoring the increasing concatenation of prime factors including
# repetitions. Further information can be found on Wikipedia and OEIS.
# https://en.wikipedia.org/wiki/Home_prime
# https://oeis.org/A037274
#
# Example: As given in the Wikipedia page,
# HP(10) = 773, as 10 factors as 2×5, yielding HP10(1) = 25,
#       25 factors as 5×5 yielding HP10(2) = HP25(1) = 55,
#       55 = 5×11 implies HP10(3) = HP25(2) = HP55(1) = 511,
#       and 511 = 7×73 gives HP10(4) = HP25(3) = HP55(2) = HP511(1) = 773,
#       a prime number.
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

say hp($_) for @ARGV;

#=============================================================================
sub hp($n)
{
    use Math::Prime::Util qw/factor is_prime/;

    while ( ! is_prime($n) )
    {
        $n = 0 + join("", factor($n))
    }
    return $n;
}

sub runTest
{
    use Test2::V0;

    is( hp(2), 2, "hp(2)");
    is( hp(4), 211, "hp(4)");
    is( hp(9), 311, "hp(9)");
    is (hp(10), 773, "hp(10)");

    done_testing;
}
