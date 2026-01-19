#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 357 Task 2  Unique Fraction Generator
#=============================================================================
# Given a positive integer N, generate all unique fractions you can create
# using integers from 1 to N and follow the rules below:
#   - Use numbers 1 through N only (no zero)
#   - Create fractions like numerator/denominator
#   - List them in ascending order (from smallest to largest)
#   - If two fractions have the same value (like 1/2 and 2/4),
#     only show the one with the smallest numerator
# 
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

say join(", ", ufg($_)->@*) for @ARGV;

#=============================================================================
sub ufg($n)
{
    my %f = ( 1 => { fraction => "1/1", num => 1, den => 1 } );

    for my $num ( 1 .. $n )
    {
        for my $den ( 1 .. $n )
        {
            my $val = $num / $den;
            if ( (! exists $f{$val}) || $f{$val}{num} > $num )
            {
                $f{$val} = { fraction => "$num/$den", num => $num, den => $den };
            }
        }
    }

    my @use = sort { $a <=> $b } keys %f;
    $logger->debug("use: @use");
    return [ map { $_->{fraction} } @f{@use} ];
}

sub runTest
{
    use Test2::V0;

    is( ufg(3), [ qw( 1/3 1/2 2/3 1/1 3/2 2/1 3/1 ) ], "Example 1");
    is( ufg(4), [ qw( 1/4 1/3 1/2 2/3 3/4 1/1 4/3 3/2 2/1 3/1 4/1 ) ], "Example 3");
    is( ufg(1), [ qw( 1/1 ) ], "Example 3");
    is( ufg(6), [ qw(1/6 1/5 1/4 1/3 2/5 1/2 3/5 2/3 3/4 4/5 5/6 1/1 6/5 5/4 4/3 3/2 5/3 2/1 5/2 3/1 4/1 5/1 6/1) ] , "Example 4");
    is( ufg(5), [ qw(1/5 1/4 1/3 2/5 1/2 3/5 2/3 3/4 4/5 1/1 5/4 4/3 3/2 5/3 2/1 5/2 3/1 4/1 5/1) ], "Example 5");

    done_testing;
}
