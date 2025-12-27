#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
353-2: Validate Coupon     Submitted by: Mohammad Sajid Anwar
You are given three arrays, @codes, @names and @status.

Write a script to validate codes in the given array.

A code is valid when the following conditions are true:
- codes[i] is non-empty and consists only of alphanumeric characters (a-z, A-Z, 0-9) and underscores (_).
- names[i] is one of the following four categories: "electronics", "grocery", "pharmacy", "restaurant".
- status[i] is true.
Return an array of booleans indicating validity: output[i] is true if and only if codes[i], names[i] and status[i] are all valid.

=end comment

my @Test =
    {
        codes  => ("A123", "B_456", "C789", "D@1", "E123"),
        names  => ("electronics", "restaurant", "electronics",
                        "pharmacy", "grocery"),
        status => ("true", "false", "true", "true", "true"),
        expect => (True, False, True, False, True),
    }, {
        codes  => ("Z_9", "AB_12", "G01", "X99", "test"),
        names  => ("pharmacy", "electronics",
                        "grocery", "electronics", "unknown"),
        status => ("true", "true", "false", "true", "true"),
        expect => (True, True, False, True, False),
    }, {
        codes  => ("_123", "123", "", "Coupon_A", "Alpha"),
        names  => ("restaurant", "electronics",
                        "electronics", "pharmacy", "grocery"),
        status => ("true", "true", "false", "true", "true"),
        expect => (True, True, False, True, True),
    }, {
        codes  => ("ITEM_1", "ITEM_2", "ITEM_3", "ITEM_4"),
        names  => ("electronics", "electronics", "grocery", "grocery"),
        status => ("true", "true", "true", "true"),
        expect => (True, True, True, True),
    },
    {
        codes  => ("CAFE_X", "ELEC_100", "FOOD_1", "DRUG_A", "ELEC_99"),
        names  => ("restaurant", "electronics",
                        "grocery", "pharmacy", "electronics"),
        status => ("true", "true", "true", "true", "false"),
        expect =>(True, True, True, True, False),
    },
;
plan +@Test;

sub task( @code, @name, @status --> Array) {
    die 'mismatched array sizes' unless +@code == +@name == +@status;

            sub validate( \i -->Bool) {
                    @status[i] eq 'true'
                and 
                (so @name[i] eq one <electronics grocery pharmacy restaurant>)
                and so @code[i] ~~ m/ ^ <[ a..z A..Z 0..9 _]>+ $ /
            }

    Array( ( for ^@status -> \i { validate i } ) );
}

for @Test -> %in {
    is task( %in<codes>, %in{'names'}, %in{'status'}), %in<expect>;
}

done-testing;

my @code  = "ITEM_1", "ITEM_2", "ITEM_3", "ITEM_4";
my @name  = "electronics", "electronics", "grocery", "grocery";
my @status = "true", "true", "true", "true";

say   qq{\nInput: @code  =  ("@code.join('", "')")\n}
      ~ qq{       @names  = ("@name.join('", "')")\n}
      ~ qq{       @status = ("@status.join('", "')")\n}
    ~ "Output: (", ( task( @code, @name, @status)».lc ).join( ", "),")";
