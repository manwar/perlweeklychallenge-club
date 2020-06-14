#!/usr/bin/perl

use strict;
use warnings;

my $string = "perlweeklychallenge";
my $words  = [ "weekly", "challenge", "perl" ];
my $match  = word_break($string, $words);

print sprintf("%s\n", join (", ", @$match));

sub word_break {
    my ($string, $words) = @_;

    my $matched = [ grep { $string =~ /$_/i } @$words ];
    return [0] unless scalar @$matched;

    my $search_order = {};
    foreach my $word (@$matched) {
        $search_order->{index($string, $word)} = $word;
    }

    return [
        map  { $search_order->{$_} }
        sort { $a <=> $b } keys %$search_order
    ];
}
