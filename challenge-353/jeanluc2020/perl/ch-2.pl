#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-353/#TASK2
#
# Task 2: Validate Coupon
# =======================
#
# You are given three arrays, @codes, @names and @status.
#
# Write a script to validate codes in the given array.
#
# A code is valid when the following conditions are true:
# - codes[i] is non-empty and consists only of alphanumeric characters (a-z,
#   A-Z, 0-9) and underscores (_).
# - names[i] is one of the following four categories: "electronics", "grocery",
#    "pharmacy", "restaurant".
# - status[i] is true.
#
# Return an array of booleans indicating validity: output[i] is true if and
# only if codes[i], names[i] and status[i] are all valid.
#
## Example 1
##
## Input: @codes  = ("A123", "B_456", "C789", "D@1", "E123")
##        @names  = ("electronics", "restaurant", "electronics", "pharmacy", "grocery")
##        @status = ("true", "false", "true", "true", "true")
## Output: (true, false, true, false, true)
#
#
## Example 2
##
## Input: @codes  = ("Z_9", "AB_12", "G01", "X99", "test")
##        @names  = ("pharmacy", "electronics", "grocery", "electronics", "unknown")
##        @status = ("true", "true", "false", "true", "true")
## Output: (true, true, false, true, false)
#
#
## Example 3
##
## Input: @codes  = ("_123", "123", "", "Coupon_A", "Alpha")
##        @names  = ("restaurant", "electronics", "electronics", "pharmacy", "grocery")
##        @status = ("true", "true", "false", "true", "true")
## Output: (true, true, false, true, true)
#
#
## Example 4
##
## Input: @codes  = ("ITEM_1", "ITEM_2", "ITEM_3", "ITEM_4")
##        @names  = ("electronics", "electronics", "grocery", "grocery")
##        @status = ("true", "true", "true", "true")
## Output: (true, true, true, true)
#
#
## Example 5
##
## Input: @codes  = ("CAFE_X", "ELEC_100", "FOOD_1", "DRUG_A", "ELEC_99")
##        @names  = ("restaurant", "electronics", "grocery", "pharmacy", "electronics")
##        @status = ("true", "true", "true", "true", "false")
## Output: (true, true, true, true, false)
#
############################################################
##
## discussion
##
############################################################
#
# For each index, we check all necessary elements for validity and record
# "false" if one of them isn't fulfilled. In the end, add "true" if we didn't
# add "false" earlier for this index.
#
use v5.36;

validate_coupon(["A123", "B_456", "C789", "D\@1", "E123"],
                ["electronics", "restaurant", "electronics", "pharmacy", "grocery"],
                ["true", "false", "true", "true", "true"]);
validate_coupon(["Z_9", "AB_12", "G01", "X99", "test"],
                ["pharmacy", "electronics", "grocery", "electronics", "unknown"],
                ["true", "true", "false", "true", "true"]);
validate_coupon(["_123", "123", "", "Coupon_A", "Alpha"],
                ["restaurant", "electronics", "electronics", "pharmacy", "grocery"],
                ["true", "true", "false", "true", "true"]);
validate_coupon(["ITEM_1", "ITEM_2", "ITEM_3", "ITEM_4"],
                ["electronics", "electronics", "grocery", "grocery"],
                ["true", "true", "true", "true"]);
validate_coupon(["CAFE_X", "ELEC_100", "FOOD_1", "DRUG_A", "ELEC_99"],
                ["restaurant", "electronics", "grocery", "pharmacy", "electronics"],
                ["true", "true", "true", "true", "false"]);

sub validate_coupon($codes, $names, $status) {
    say "Input: \@codes = (\"" . join("\", \"", @{$codes}) . "\"),";
    say "       \@names = (\"" . join("\", \"", @{$names}) . "\"),";
    say "       \@status = (\"" . join("\", \"", @{$status}) . "\")";
    my $max = scalar(@{$codes}) - 1;
    my @output = ();
    foreach my $i (0..$max) {
        if(length($codes->[$i]) == 0) {
            push @output, "false";
            next;
        }
        if($codes->[$i] =~ m/[^a-zA-Z0-9_]/) {
            push @output, "false";
            next;
        }
        if($names->[$i] ne "electronics" and $names->[$i] ne "grocery" and
           $names->[$i] ne "pharmacy" and $names->[$i] ne "restaurant") {
           push @output, "false";
           next;
        }
        if($status->[$i] ne "true") {
            push @output, "false";
            next;
        }
        push @output, "true";
    }
    say "Output: (\"" . join("\", \"", @output) . "\")";
}
