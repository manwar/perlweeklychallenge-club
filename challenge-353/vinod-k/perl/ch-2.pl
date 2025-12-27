#!/usr/bin/perl

use strict;
use warnings;

sub validate_codes {
    my ($codes_ref, $names_ref, $status_ref) = @_;

    my @codes  = @$codes_ref;
    my @names  = @$names_ref;
    my @status = @$status_ref;

    my @valid_categories = qw(electronics grocery pharmacy restaurant);
    my @result;

    for my $i (0 .. $#codes) {
        my $code_ok = ($codes[$i] ne '' && $codes[$i] =~ /^[A-Za-z0-9_]+$/);

        my $name_ok = grep { defined $names[$i] && $names[$i] eq $_ } @valid_categories;

        my $status_ok = defined $status[$i] && $status[$i] eq 'true';

        push @result, ($code_ok && $name_ok && $status_ok) ? "true" : "false";
    }

    return @result;
}

sub show_case {
    my ($label, $codes_ref, $names_ref, $status_ref) = @_;

    my @codes  = @$codes_ref;
    my @names  = @$names_ref;
    my @status = @$status_ref;

    print "$label\n";
    print "Input: \@codes  = (\"" . join('", "', @codes)  . "\")\n";
    print "       \@names  = (\"" . join('", "', @names)  . "\")\n";
    print "       \@status = (\"" . join('", "', @status) . "\")\n";

    my @out = validate_codes($codes_ref, $names_ref, $status_ref);
    print "Output: (" . join(", ", @out) . ")\n\n";
}

# Example 1
my @codes1  = ("A123", "B_456", "C789", "D", "E123");
my @names1  = ("electronics", "restaurant", "electronics", "pharmacy", "grocery");
my @status1 = ("true", "false", "true", "true", "true");
show_case("Example 1", \@codes1, \@names1, \@status1);

# Example 2
my @codes2  = ("Z_9", "AB_12", "G01", "X99", "test");
my @names2  = ("pharmacy", "electronics", "grocery", "electronics", "unknown");
my @status2 = ("true", "true", "false", "true", "true");
show_case("Example 2", \@codes2, \@names2, \@status2);

# Example 3
my @codes3  = ("_123", "123", "", "Coupon_A", "Alpha");
my @names3  = ("restaurant", "electronics", "electronics", "pharmacy", "grocery");
my @status3 = ("true", "true", "false", "true", "true");
show_case("Example 3", \@codes3, \@names3, \@status3);

# Example 4
my @codes4  = ("ITEM_1", "ITEM_2", "ITEM_3", "ITEM_4");
my @names4  = ("electronics", "electronics", "grocery", "grocery");
my @status4 = ("true", "true", "true", "true");
show_case("Example 4", \@codes4, \@names4, \@status4);

# Example 5
my @codes5  = ("CAFE_X", "ELEC_100", "FOOD_1", "DRUG_A", "ELEC_99");
my @names5  = ("restaurant", "electronics", "grocery", "pharmacy", "electronics");
my @status5 = ("true", "true", "true", "true", "false");
show_case("Example 5", \@codes5, \@names5, \@status5);
