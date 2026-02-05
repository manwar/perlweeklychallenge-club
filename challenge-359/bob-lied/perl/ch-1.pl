#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 359 Task 1  Digital Root
#=============================================================================
# You are given a positive integer, $int. Write a function that calculates
# the additive persistence of a positive integer and also return the digital
# root. Digital root is the recursive sum of all digits in a number until a
# single digit is obtained. Additive persistence is the number of times you
# need to sum the digits to reach a single digit.
# Example 1 Input: $int = 38
#		Output: Persistence  = 2 Digital Root = 2
#   38 => 3 + 8 => 11
#   11 => 1 + 1 => 2
# Example 2 Input: $int = 7
#		Output: Persistence  = 0 Digital Root = 7
# Example 3 Input: $int = 999
#		Output: Persistence  = 2 Digital Root = 9
#   999 => 9 + 9 + 9 => 27
#   27  => 2 + 7 => 9
# Example 4 Input: $int = 1999999999
#		Output: Persistence  = 3 Digital Root = 1
#   1999999999 => 1 + 9 + 9 + 9 + 9 + 9 + 9 + 9 + 9 + 9 => 82
#   82 => 8 + 2 => 10
#   10 => 1 + 0 => 1
# Example 5 Input: $int = 101010
#		Output: Persistence  = 1 Digital Root = 3
#   101010 => 1 + 0 + 1 + 0 + 1 + 0 => 3
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

for ( @ARGV )
{
    my ($persistence, $root) = droot($_)->@*;
    say "Persistence  = $persistence\nDigital Root = $root"
}


#=============================================================================
sub droot($int)
{
    use List::Util qw/sum0/;

    my $persistence = 0;
    my $root = $int;
#   while ( $root > 9 )
#   {
#       $persistence++;
#       $root = sum0 split //, $root;
#   }

    for ( $root = $int; $root > 9 ; $root = sum0 split //, $root )
    {
        $logger->debug("$root, $persistence");
        $persistence++;
    }
    return [$persistence, $root];
}

sub runTest
{
    use Test2::V0;

    is( droot(        38), [2,2], "Example 1");
    is( droot(         7), [0,7], "Example 2");
    is( droot(       999), [2,9], "Example 3");
    is( droot(1999999999), [3,1], "Example 4");
    is( droot(    101010), [1,3], "Example 5");

    done_testing;
}
