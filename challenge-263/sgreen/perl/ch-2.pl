#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use JSON qw(decode_json encode_json);

sub merge_items(@arrays) {
    # Calculate the total of each items
    my %totals = ();
    foreach my $array (@arrays) {
        foreach my $item (@$array) {
            my ( $item_id, $item_qty ) = @$item;
            $totals{$item_id} += $item_qty;
        }
    }

    # Turn this into a sorted list of item_id and item_qty pairs
    return [ map { [ $_, $totals{$_} ] } ( sort { $a <=> $b } keys(%totals) ) ];
}

sub main (@array) {
    # Convert each input into a list of lists
    my @inputs = ();
    foreach my $json_str (@array) {
        push @inputs, decode_json($json_str);
    }

    # Do the challenge
    my $result = merge_items(@inputs);
    say encode_json($result);
}

main(@ARGV);