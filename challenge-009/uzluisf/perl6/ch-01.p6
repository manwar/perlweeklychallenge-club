#!/usr/bin env perl6

=begin comment
Challenge 009#1:

Write a script that finds the first square number that has at least 5 distinct
digits.
=end comment

sub find-first-square( UInt:D $with-different-n-digits where * > 0 ) {
    my @nums;
    for 1..∞ {
        my $square = $_ ** 2;
        if has-at-least($square, $with-different-n-digits) {
            @nums.push: $square;
            return @nums if @nums == 5;
        }
    }

    sub has-at-least( Int:D $number, Int:D $num-of-digits ) {
        my %digits = ($_ => True for $number.comb);
        %digits == $num-of-digits;
    }
}

sub MAIN() {
    put find-first-square(5);
}

=begin comment
One-liner:

(1..∞).map(* ** 2).grep(.comb.unique ≥ 5).head(5)
=end comment
