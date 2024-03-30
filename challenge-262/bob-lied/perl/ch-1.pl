#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
#  
# ch-1.pl Perl Weekly Challenge 262 Task 1 Max Positive Negative
#=============================================================================
# You are given an array of integers, @ints.
# Write a script to return the maximum number of either positive
# or negative integers in the given array.
# Example 1 Input: @ints = (-3, 1, 2, -1, 3, -2, 4)
#           Output: 4
#   Count of positive integers: 4
#   Count of negative integers: 3
#   Maximum of count of positive and negative integers: 4
# Example 2 Input: @ints = (-1, -2, -3, 1)
#           Output: 3
# Example 3 Input: @ints = (1,2)
#           Output: 2
#=============================================================================

use v5.38;

use builtin qw/true false/; no warnings "experimental::builtin";

use feature 'class'; no warnings "experimental::class";

use List::Util qw/max/;

class Bucket {
    my $id = 0;
    ADJUST { ++$id }

    field $name :param = "Bucket$id";
    field $condition :param = sub($n) { true };
    field $_count = 0;

    method contains($n) {
        $_count++ if $condition->($n);
    }
    method count() { return $_count }
}

class BucketCollection {
    field @coll;

    method add($bucket) { push @coll, $bucket; return $self; }

    method place($n) { $_->contains($n) for @coll; return $self }
    method biggestNum() { return List::Util::max map { $_->count } @coll }
}

sub mpn(@ints)
{
    my $buckets = BucketCollection->new()
        ->add( Bucket->new(name => "positive", condition => sub($n) { $n > 0 } ) )
        ->add( Bucket->new(name => "negative", condition => sub($n) { $n < 0 } ) );

    $buckets->place($_) foreach @ints;
    return $buckets->biggestNum();
}


use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say "OO solution: ", mpn(@ARGV);
say maxPosNeg(@ARGV);


sub maxPosNeg(@ints)
{
    my ($pos, $neg) = (0, 0);
    foreach ( @ints )
    {
        if    ( $_ > 0 ) { $pos++ }
        elsif ( $_ < 0 ) { $neg++ }
    }
    return ( $pos > $neg ) ? $pos : $neg;
}

# Return -1, 0, or 1 for negative, zero, or positive
sub sign($n) { return ( $n < 0 ? -1 : ( $n > 0 ? 1 : 0 ) ) }

sub maxPN2(@ints)
{
    use List::Util qw/max/;

    my @range = ( 0, 0, 0 );

    $range[ sign($_) ]++ foreach @ints;

    return max( @range[1,2] );
}

sub runTest
{
    use Test2::V0;

    is( sign(-3), -1, "Sign negative");
    is( sign( 7),  1, "Sign positive");

    is( maxPosNeg(-3, 1, 2, -1, 3, -2, 4), 4, "Example 1");
    is( maxPosNeg(-1, -2, -3, 1         ), 3, "Example 2");
    is( maxPosNeg(1, 2                  ), 2, "Example 3");
    is( maxPosNeg(), 0, "Empty list");

    is( maxPN2(-3, 1, 2, -1, 3, -2, 4), 4, "Example 1");
    is( maxPN2(-1, -2, -3, 1         ), 3, "Example 2");
    is( maxPN2(1, 2                  ), 2, "Example 3");
    is( maxPN2(), 0, "Empty list");

    done_testing;
}
