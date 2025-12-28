#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 353 Task 2: Validate Coupon
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use List::Util qw( zip mesh );

sub validate_coupon_for_index( $codes, $names, $status ) {
    my @valid_names = qw( electronics grocery pharmacy restaurant );
    my %name_is_valid = map +( $_ => 1 ), @valid_names;
    my @results;
    for ( keys $codes->@* ) {
        push @results,
            $codes->[$_] =~ /^[a-zA-Z0-9_]+$/
                && $name_is_valid{ $names->[$_] }
                && $status->[$_] && $status->[$_] !~ /^false/i
    }
    return @results;
}

sub validate_coupon_map_index( $codes, $names, $status ) {
    my @valid_names = qw( electronics grocery pharmacy restaurant );
    my %name_is_valid = map +( $_ => 1 ), @valid_names;
    return map {
        $codes->[$_] =~ /^[a-zA-Z0-9_]+$/
            && $name_is_valid{ $names->[$_] }
            && $status->[$_] && $status->[$_] !~ /^false/i
    } keys $codes->@*;
}

sub validate_coupon_map_zip( $codes, $names, $status ) {
    my @valid_names = qw( electronics grocery pharmacy restaurant );
    my %name_is_valid = map +( $_ => 1 ), @valid_names;
    return map {
        $_->[0] =~ /^[a-zA-Z0-9_]+$/
            && $name_is_valid{ $_->[1] }
            && $_->[2] && $_->[2] !~ /^false/i
    } zip $codes, $names, $status;
}

sub validate_coupon_for_multi( $codes, $names, $status ) {
    my @valid_names = qw( electronics grocery pharmacy restaurant );
    my %name_is_valid = map +( $_ => 1 ), @valid_names;
    my @results;
    for my ( $code, $name, $stat )( mesh $codes, $names, $status ) {
        push @results,
            $code =~ /^[a-zA-Z0-9_]+$/
                && $name_is_valid{$name}
                && $stat && $stat !~ /^false/i
    }
    return @results;
}

*validate_coupon = \&validate_coupon_map_index;

use Test2::V0 qw( -no_srand );
use builtin qw( true false );

is [ validate_coupon(
        ["A123", "B_456", "C789", "D\@1", "E123"],
        [ "electronics", "restaurant", "electronics", "pharmacy", "grocery", ],
        [ "true", "false", "true", "true", "true"] ) ],
    [ T, F, T, F, T ],
    'Example 1';
is [ validate_coupon(
        ["Z_9", "AB_12", "G01", "X99", "test"],
        ["pharmacy", "electronics", "grocery", "electronics", "unknown"],
        ["true", "true", "false", "true", "true"] ) ],
    [ T, T, F, T, F ],
    'Example 2';
is [ validate_coupon(
        ["_123", 123, "", "Coupon_A", "Alpha"],
        [ "restaurant", "electronics", "electronics", "pharmacy", "grocery" ],
        ["true", "true", "false", "true", "true"] ) ],
    [ T, T, F, T, T ],
    'Example 3';
is [ validate_coupon(
        ["ITEM_1", "ITEM_2", "ITEM_3", "ITEM_4"],
        ["electronics", "electronics", "grocery", "grocery"],
        ["true", "true", "true", "true"] ) ],
    [ T, T, T, T ],
    'Example 4';
is [ validate_coupon(
        ["CAFE_X", "ELEC_100", "FOOD_1", "DRUG_A", "ELEC_99"],
        ["restaurant", "electronics", "grocery", "pharmacy", "electronics"],
        [ true, true, true, true, false ] ) ],
    [ T, T, T, T, F ],
    'Example 5 (using boolean values)';

done_testing;
