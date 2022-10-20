#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use Math::Combinatorics qw( permute );

sub triplet {
    my @triplets;
    my %stored;

    for ( permute(@_) ){

        # Rules:
        # 1. a + b > c
        # 2. b + c > a
        # 3. a + c > b
        # 4. a + b + c is maximum.

        my ($a,$b,$c) = @$_;
        next unless $a + $b > $c;
        next unless $b + $c > $a;
        next unless $a + $c > $b;

        my $key = "$a $b $c";
        next if $stored{$key};

        push @triplets, [$a,$b,$c, $a+$b+$c ];
        $stored{$key}++;
    }

    # When multiple triplets, pick where:
    # a >= b >= c

    my $triplet;
    my @max;
    my @ordered;

    # Multiple triplets.
    if (@triplets > 1) {
        for (@triplets) {
            my ($a,$b,$c,$sum) = @$_;
            if ( not @max or $sum > $max[0][-1] ) {
                @max = ();
                push @max, $_;
            }
            elsif($sum == $max[0][-1]){
                push @max, $_;
            }
        }

        # Multiple maximums.
        if (@max > 1) {
            for (@max) {
                my ($a,$b,$c,$sum) = @$_;
                next unless $a >= $b and $b >= $c;
                push @ordered, $_;
            }
            $triplet = $ordered[0];
        }
        else {
            $triplet = $max[0];
        }
    }
    else {
        $triplet = $triplets[0];
    }

    $triplet //= [];
    my @trip = @$triplet;
    pop @trip if @trip;

    @trip;
}

my @cases = (
    {
        name   => 'Example 1',
        input  => [ 1, 2, 3, 2 ],
        output => [ 3, 2, 2 ],
    },
    {
        name   => 'Example 2',
        input  => [ 1, 3, 2 ],
        output => [],
    },
    {
        name   => 'Example 3',
        input  => [ 1, 1, 2, 3 ],
        output => [],
    },
    {
        name   => 'Example 4',
        input  => [ 2, 4, 3 ],
        output => [ 4, 3, 2 ],
    },

);

for ( @cases ) {
    is_deeply(
        [ triplet( $_->{input}->@* ) ],
        $_->{output},
        $_->{name}
    );
}

done_testing();
