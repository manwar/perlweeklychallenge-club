#!/usr/bin/env perl

# You are given two array of strings.

# Write a script to return the number of strings that appear exactly once
# in each of the two given arrays. String comparison is case sensitive.
# Description of Challenge goes here

use 5.018;
use strict;
use warnings;
use File::JSON::Slurper qw(read_json);
use Data::Printer;

use Test2::V0;
plan tests => 5;

my $json_ref = read_json( __FILE__ =~ s/pl$/json/r )
    or die "ERROR: could not read test data from json file\n";
my $challenge_ref  = $json_ref->{ challenge };
my $input_vars_ref = $json_ref->{ input_vars };
my $examples_ref   = $json_ref->{ examples };

printf qq{Challenge: %s Task %s: %s\n\n},
    $challenge_ref->{ week },
    $challenge_ref->{ task },
    $challenge_ref->{ name };

is( single_common_word( $_->{ in } ), $_->{ out }, $_->{ name } )
    for @{ $examples_ref };

sub single_common_word {
    my @array1 = $_[0]->[0]->@*;
    my @array2 = $_[0]->[1]->@*;
    print 'Input: @array2 = (' . join( ', ', @array1 ) . ")\n";
    print '       @array2 = (' . join( ', ', @array2 ) . ")\n";
    my $result = q{0};

    my ( %array1, %array2 );
    $array1{ $_ }++ for @array1;
    $array2{ $_ }++ for @array2;

    for ( keys %array1 ) {
        $result++ if ( $array1{ $_ } == 1 && $array2{ $_ } == 1 );
    }

    printf qq{Output: %s\n}, $result;
    return $result;
}
