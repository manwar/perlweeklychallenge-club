#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
#  
# ch-1.pl Perl Weekly Challenge 171 Task 1  Abundant Odd Number
#=============================================================================
# Write a script to generate first 20 Abundant Odd Numbers.
# According to wikipedia, A number n for which the sum of divisors σ(n) > 2n,
# or, equivalently, the sum of proper divisors (or aliquot sum) s(n) > n.
# For example, 945 is the first Abundant Odd Number.
# Sum of divisors:
# 1 + 3 + 5 + 7 + 9 + 15 + 21 + 27 + 35 + 45 + 63 + 105 + 135 + 189 + 315 = 975
# https://en.wikipedia.org/wiki/Abundant_number
# https://oeis.org/search?q=odd+abundant+number&go=Search
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

say join(', ', abundant(shift)->@*);

#=============================================================================
sub abundant($howMany = 20)
{
    use Math::Prime::Util qw/divisors/;
    use List::Util qw/sum/;

    # Given the first one in the task description
    my @abundant = ( 945 );
    $howMany--;
    my $n = 947;

    while ( $howMany )
    {
        my @d = divisors($n); pop @d; # Includes n itself
        my $s = sum(@d);

        if ( $s > $n )
        {
            $howMany--;
            push @abundant, $n;
            $logger->debug("FOUND #$howMany: $n");
        }
        $n += 2;
    }
    return \@abundant;
}

sub runTest
{
    use Test2::V0;

    my @num = abundant(20)->@*;
    my @sequence = ( 945, 1575, 2205, 2835, 3465, 4095, 4725, 5355, 5775, 5985,
                    6435, 6615, 6825, 7245, 7425, 7875, 8085, 8415, 8505, 8925
                   ); 

    for ( 0 .. 19 )
    {
        is( $num[$_], $sequence[$_], "AN $_ $sequence[$_]");
    }

    done_testing;
}
