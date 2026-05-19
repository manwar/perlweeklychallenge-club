#!/usr/bin/env perl

# You are given a list and a non-negative integer.

# Write a script to divide the given list into given non-negative integer
# equal parts. Return -1 if the integer is more than the size of the list.

use 5.018;
use strict;
use warnings;
use File::JSON::Slurper qw(read_json);
use Data::Printer;

use Test2::V0;
plan tests => 6;

my $json_ref       = read_json( __FILE__ =~ s/pl$/json/r );
my $challenge_ref  = $json_ref->{ challenge };
my $input_vars_ref = $json_ref->{ input_vars };
my $examples_ref   = $json_ref->{ examples };

printf qq{Challenge: %s Task %s: %s\n\n},
    $challenge_ref->{ week },
    $challenge_ref->{ task },
    $challenge_ref->{ name };

is( list_division( $_->{ in } ), $_->{ out }, $_->{ name } )
    for @{ $examples_ref };

sub list_division {
    my @data = $_[0]->[0];
    my $n    = $_[0]->[1]->[0];
    my @list = @{ $data[0] };
    printf qq{Input: %s = (%s)  %s = %d\n}, $input_vars_ref->[0],
        ( join ',' => @list ),
        $input_vars_ref->[1], $n;
    my @results;

    my $list_size = scalar @list;
    return [[-1]] if ( $n > $list_size );

    my ( $part_size, $extra ) = div_mod( $list_size, $n );

    while (@list) {
        my @arr;
        for my $j ( 1 .. $part_size ) {
            push @arr, shift @list;
        }
        if ( $extra > 0 ) {
            push @arr, shift @list;
            $extra--;
        }
        push @results, \@arr;
    }

    my $out;
    $out .= sprintf qq{(%s), }, join ', ' => @{$_} for @results;
    printf qq{Output: (%s)\n}, $out;
    return \@results;
}

sub div_mod {    # return result of division and modulus
    return int( $_[0] / $_[1] ), ( $_[0] % $_[1] );
}
