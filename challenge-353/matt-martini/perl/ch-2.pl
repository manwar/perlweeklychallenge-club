#!/usr/bin/env perl

# You are given three arrays, @codes, @names and @status.

# Write a script to validate codes in the given array.

# A code is valid when the following conditions are true:
# - codes[i] is non-empty and consists only of alphanumeric characters (a-z, A-Z, 0-9) and underscores (_).
# - names[i] is one of the following four categories: "electronics", "grocery", "pharmacy", "restaurant".
# - status[i] is true.

# Return an array of booleans indicating validity: output[i] is true if and only if codes[i], names[i] and status[i] are all valid.

use 5.018;
use strict;
use warnings;
use Test2::V0;
use List::Util::Find qw(hasstr);
use Data::Printer;
use Data::Dumper::Simple;

plan tests => 5;

my $valid_code_re    = qr{[^a-zA-Z0-9_]};
my @valid_categories = qw(electronics grocery pharmacy restaurant);

sub validate_coupon {
    my $code_ref   = shift;
    my $names_ref  = shift;
    my $status_ref = shift;

    print 'Input: @codes = (' . join( ', ', @{ $code_ref } ) . ")\n";
    print '       @names = (' . join( ', ', @{ $names_ref } ) . ")\n";
    print '       @status = (' . join( ', ', @{ $status_ref } ) . ")\n";

    my @results;
    VALIDATE:
    foreach ( my $i = 0; $i <= $#{ $code_ref }; $i++ ) {
        my $valid = 'true';

        if ( $status_ref->[$i] eq 'false' ) {
            $valid = 'false';
        }
        unless ( hasstr $names_ref->[$i], @valid_categories ) {
            $valid = 'false';
        }
        if ( $code_ref->[$i] =~ m{$valid_code_re} ) {
            $valid = 'false';
        }

        push @results, $valid;
    }

    print 'Output: @results = (' . join( ', ', @results ) . ")\n";
    return \@results;
}

is(
    validate_coupon(
                         [ "A123", "B_456", "C789", "D@1", "E123" ],
                         [  "electronics", "restaurant", "electronics", "pharmacy",
                            "grocery"
                         ],
                         [ "true", "false", "true", "true", "true" ],
                   ),
    [ 'true', 'false', 'true', 'false', 'true' ],
    'example 1'
  );

is(
    validate_coupon(
                         [ "Z_9", "AB_12", "G01", "X99", "test" ],
                         [  "pharmacy", "electronics", "grocery", "electronics",
                            "unknown"
                         ],
                         [ "true", "true", "false", "true", "true" ],
                   ),
    [ 'true', 'true', 'false', 'true', 'false' ],
    'example 2'
  );

is(
    validate_coupon(
                         [ "_123", "123", "", "Coupon_A", "Alpha" ],
                         [  "restaurant", "electronics", "electronics", "pharmacy",
                            "grocery"
                         ],
                         [ "true", "true", "false", "true", "true" ],
                   ),
    [ 'true', 'true', 'false', 'true', 'true' ],
    'example 3'
  );

is(
    validate_coupon(
                         [ "ITEM_1",      "ITEM_2",      "ITEM_3",  "ITEM_4" ],
                         [ "electronics", "electronics", "grocery", "grocery" ],
                         [ "true",        "true",        "true",    "true" ],
                   ),
    [ 'true', 'true', 'true', 'true' ],
    'example 4'
  );

is(
    validate_coupon(
                         [ "CAFE_X", "ELEC_100", "FOOD_1", "DRUG_A", "ELEC_99" ],
                         [  "restaurant", "electronics", "grocery", "pharmacy",
                            "electronics"
                         ],
                         [ "true", "true", "true", "true", "false" ],
                   ),
    [ 'true', 'true', 'true', 'true', 'false' ],
    'example 5'
  );

