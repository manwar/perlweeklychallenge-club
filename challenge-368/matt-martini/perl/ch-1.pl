#!/usr/bin/env perl

# You are given a given a string number and a character digit.

# Write a script to remove exactly one occurrence of the given character
# digit from the given string number, resulting the decimal form is
# maximized.

use 5.018;
use strict;
use warnings;
use Perl6::Slurp;
use JSON::MaybeXS qw(decode_json);
use Data::Printer;

use Test2::V0;
plan tests => 5;
say "-" x 80;

sub make_it_bigger {
    my $str  = $_[0]->[0];
    my $char = $_[0]->[1];
    printf qq{ Input: \$str = "%s", \$char = %s\n }, $str, $char;
    my $result = 0;

    my @numbers;
    my $indx = 0;
    my $pos  = 0;
    while ( $indx >= 0 ) {
        my $new_str = $str;
        $indx = index $str, $char, $pos;
        $pos  = $indx + 1;

        if ( $indx >= 0 ) {
            substr $new_str, $indx, 1, q{};
            push @numbers, $new_str;
        }
    }
    @numbers = sort { $b <=> $a } @numbers;
    $result = $numbers[0];

    printf qq{Output: "%s"\n}, $result;
    return $result;
}

my $input_data   = slurp __FILE__ =~ s/pl$/json/r;
my $examples_ref = decode_json($input_data);
is( make_it_bigger( $_->{ input } ), $_->{ output }, $_->{ name } )
    for @{ $examples_ref };
