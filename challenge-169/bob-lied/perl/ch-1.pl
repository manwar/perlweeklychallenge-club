#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 169 Task 1  Brilliant Numbers
#=============================================================================
# Write a script to generate first 20 Brilliant Numbers.
# Brilliant numbers are numbers with two prime factors of the same length.
# The number should have exactly two prime factors, i.e. it’s the product of
# two primes of the same length.  For example,
# 24287 = 149 x 163
# 24289 = 107 x 227
# Output   4,   6,   9,  10,  14,  15,  21,  25,  35,  49,
#        121, 143, 169, 187, 209, 221, 247, 253, 289, 299
#=============================================================================

use v5.42;

use Math::Prime::Util qw/primes/;

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

say join(", ", brilliant(shift // 20)->@* );

#=============================================================================
sub brilliant($count)
{
    my @prime = ( primes(1, 9), primes(10, 99) );
    my $have = 0;

    my @b;
    PAIR:
    for ( @prime )
    {
        while ( defined(my $first = shift @$_) )
        {
            push @b, $first * $first; $have++;

            for my $second ( $_->@* )
            {
                my $product = $first * $second;
                push @b, $product; $have++;
                $logger->debug("$have: [$first, $second] = $product");
            }
        }
    }
    return [ ( sort { $a <=> $b} @b )[0..$count-1] ]
}

sub runTest
{
    use Test2::V0;

    my $b = brilliant(20);

    is( $b->[ 0],   4, "B(1)");
    is( $b->[ 1],   6, "B(2)");
    is( $b->[ 2],   9, "B(3)");
    is( $b->[ 3],  10, "B(4)");
    is( $b->[ 4],  14, "B(5)");
    is( $b->[ 5],  15, "B(6)");
    is( $b->[ 6],  21, "B(7)");
    is( $b->[ 7],  25, "B(8)");
    is( $b->[ 8],  35, "B(9)");
    is( $b->[ 9],  49, "B(10)");
    is( $b->[10], 121, "B(11)");
    is( $b->[11], 143, "B(12)");
    is( $b->[12], 169, "B(13)");
    is( $b->[13], 187, "B(14)");
    is( $b->[14], 209, "B(15)");
    is( $b->[15], 221, "B(16)");
    is( $b->[16], 247, "B(17)");
    is( $b->[17], 253, "B(18)");
    is( $b->[18], 289, "B(19)");
    is( $b->[19], 299, "B(20)");

    done_testing;
}
