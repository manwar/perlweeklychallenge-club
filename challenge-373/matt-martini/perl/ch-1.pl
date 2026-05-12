#!/usr/bin/env perl

# You are given two arrays of strings.

# Write a script to return true if the two given array represent the same
# strings otherwise false.


use 5.018;
use strict;
use warnings;
use File::JSON::Slurper qw(read_json);
use Data::Printer;

use Test2::V0;
plan tests => 5;

my $json_ref       = read_json( __FILE__ =~ s/pl$/json/r );
my $challenge_ref  = $json_ref->{ challenge };
my $input_vars_ref = $json_ref->{ input_vars };
my $examples_ref   = $json_ref->{ examples };

printf qq{Challenge: %s Task %s: %s\n\n},
    $challenge_ref->{ week },
    $challenge_ref->{ task },
    $challenge_ref->{ name };

is( equal_list( $_->{ in } ), $_->{ out }->[0], $_->{ name } )
    for @{ $examples_ref };

sub equal_list {
    my @arr1 = $_[0]->[0];
    my @arr2 = $_[0]->[1];
    printf qq{ Input: %s = ("%s")\n }, $input_vars_ref->[0],
        join '", "' => @{ $arr1[0] };
    printf qq{       %s = ("%s")\n }, $input_vars_ref->[1],
        join '", "' => @{ $arr2[0] };
    my $result = q{false};

    my ( $str1, $str2 );
    $str1 .= $_ for @{ $arr1[0] };
    $str2 .= $_ for @{ $arr2[0] };
    $result = q{true} if ( $str1 eq $str2 );

    printf qq{Output: %s\n}, $result;
    return $result;
}
