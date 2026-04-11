#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 170 Task 1  Primorial Numbers
#=============================================================================
# Write a script to generate first 10 Primorial Numbers.
# Primorial numbers are those formed by multiplying successive prime numbers.
# For example,  P(0) = 1    (1)
#               P(1) = 2    (1x2)
#               P(2) = 6    (1x2×3)
#               P(3) = 30   (1x2×3×5)
#               P(4) = 210  (1x2×3×5×7)
#=============================================================================

use v5.42;
use feature 'class'; no warnings 'experimental';

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
class Primorial
{
    use Math::Prime::Util qw/next_prime/;
    field $prime = 1;
    field $product = 1;

    method get() { $prime };

    method next() {
        $prime = next_prime($prime);
        $product *= $prime;
    }
}
#=============================================================================

exit(!runTest()) if $DoTest;

my $primorial = Primorial->new();
say "P(0) = ", $primorial->get();
say "P($_) = ", $primorial->next() for 1 .. (shift // 10);

sub runTest
{
    use Test2::V0;

    my $primorial = Primorial->new();
    is( $primorial->get(),          1, "P(0)");
    is( $primorial->next(),         2, "P(1)");
    is( $primorial->next(),         6, "P(2)");
    is( $primorial->next(),        30, "P(3)");
    is( $primorial->next(),       210, "P(4)");
    is( $primorial->next(),      2310, "P(5)");
    is( $primorial->next(),     30030, "P(6)");
    is( $primorial->next(),    510510, "P(7)");
    is( $primorial->next(),   9699690, "P(8)");
    is( $primorial->next(), 223092870, "P(9)");

    done_testing;
}
