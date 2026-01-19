#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 357 Task 1  Kaprekar's Constant
#=============================================================================
# Write a function that takes a 4-digit integer and returns how many
# iterations are required to reach Kaprekar’s constant (6174). For more
# information about Kaprekar's Constant please follow the wikipedia page.
# https://en.wikipedia.org/wiki/6174
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

say kaprekar($_) for @ARGV;

#=============================================================================
sub kaprekar($n)
{
    # Must be a four-digit number
    return -1 if ( $n < 1000 || $n >= 10000 );

    # Fails for repeated digits
    for ( 1 .. 9 )
    {
        return -1 if $n == $_ * 1111;
    }

    my $count = 0;
    while ( $n != 6174 )
    {
        $logger->debug("$count: $n");

        $count++;
        my @sorted = sort { $a <=> $b } split(//, $n);

        my $n1 = sprintf("%04d", join("", @sorted));
        my $n2 = reverse $n1;

        if ( $n1 < $n2 ) { ($n1, $n2) = ($n2, $n1) };

        $n = $n1 - $n2;
        $logger->debug("$count: $n = $n1 - $n2");
    }
    return $count;
}

sub runTest
{
    use Test2::V0;

    is( kaprekar(3524),  3, "Example 1");
    is( kaprekar(6174),  0, "Example 2");
    is( kaprekar(9998),  5, "Example 3");
    is( kaprekar(1001),  4, "Example 4");
    is( kaprekar(9000),  4, "Example 5");
    is( kaprekar(1111), -1, "Example 6");

    done_testing;
}
