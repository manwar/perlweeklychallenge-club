#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 167 Task 1  Circular Prime
#=============================================================================
# Write a script to find out first 10 circular primes having at least three
# digits (base 10).  Please checkout wikipedia for more information.
# https://en.wikipedia.org/wiki/Circular_prime
# A circular prime is a prime number with the property that the number
# generated at each intermediate step when cyclically permuting its (base 10)
# digits will also be prime.
# Output   113, 197, 199, 337, 1193, 3779, 11939, 19937, 193939, 199933
#
# From the Wikipedia article, number 11 has 19 digits, so takes a long time.
#=============================================================================

use v5.44;
use Math::Prime::Util qw/is_prime/;
use List::Util qw/all/;
use feature 'class'; no warnings "experimental::class";

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

say $_ for task(shift);


#=============================================================================
# An iterator to produce candidates for possible circular primes.
#
# A circular prime with at least two digits can only consist of combinations
# of the digits 1, 3, 7 or 9, because having 0, 2, 4, 6 or 8 as the last digit
# makes the number divisible by 2, and having 0 or 5 as the last digit makes
# it divisible by 5.
#
# In effect, we can produce consecutive numbers that might be circular primes
# by counting in base 4, but replacing the digits 0,1,2,3 with 1379
class PCP
{
    field @digit = (1,3,7,9);
    field @val   = ( 0 );

    ADJUST {
    }

    method show() {
        '(' . join(" ", reverse @val) . ')';
    }
    use overload '""' => sub { $_[0]->show() };

    method get() { return join "", map { $digit[$_] } reverse @val }

    method next() {
        my $carry = 1;
        for ( my $place = 0; $place < @val && $carry == 1 ; $place++ )
        {
            $val[$place] = ($val[$place] + 1) % scalar(@digit) ;
            if ( $val[$place] != 0 )
            {
                $carry = 0;
            }
        }
        push @val, 0 if $carry;
        return 0+$self->get();
    }
}

sub rotate($n)
{
    my @rot = ( $n );
    for ( 1 .. length($n) )
    {
        push @rot, $n .= substr($n, 0, 1, "");
    }
    return @rot;
}


#=============================================================================
sub task($target)
{
    my $count = 0;
    my @list;

    my %seen;

    my $pcp = PCP->new();
    my $n;
    while ( ($n = $pcp->next()) < 100 ) {} # Need at least three digits

    while ( $count < $target )
    {
        my @rotations = rotate($n);

        if ( ! $seen{$n} && all { is_prime($_) } @rotations )
        {
            push @list, $n;
            $count++;
        }

        @seen{$_} = true for @rotations;
        $n = $pcp->next();
    }
    return @list;
}

sub runTest
{
    use Test2::V1 -ipP;

    my $PCP = PCP->new();

    is( $PCP->get(),   1, "PCP first is 1");
    is( $PCP->next(),  3, "PCP next 3");
    is( $PCP->next(),  7, "PCP next 7");
    is( $PCP->next(),  9, "PCP next 9");
    is( $PCP->next(), 11, "PCP next 11");
    is( $PCP->next(), 13, "PCP next 13");
    is( $PCP->next(), 17, "PCP next 17");
    is( $PCP->next(), 19, "PCP next 19");
    is( $PCP->next(), 31, "PCP next 31");
    $PCP->next for ( 1 .. 11 );
    is ( $PCP->get(), 99, "Last two digit number");
    is( $PCP->next(), 111, "Three digits PCP next 111");
    is( $PCP->next(), 113, "Three digits PCP next 113");

    my @list = task(10);
    is( $list[0], 113, "First of 10");
    is( $list[9], 199933, "Last of 10");

    done_testing;
}
