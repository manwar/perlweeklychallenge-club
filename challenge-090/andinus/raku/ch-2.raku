#!/usr/bin/env raku

sub MAIN (
    #= positive numbers
    Int $A is copy where * > 0,
    Int $B is copy where * > 0
) {
    my %sets;

    say "Ethopian Multiplication.\n";
    say "Start with $A, $B.";
    say "Divide $A by 2 & multiple $B by 2 at each step.";
    say "Continue until $A equals 1. Drop the remainder, both should be Integer.\n";

    say "$A, $B";
    while True {
        %sets{$A} = $B.Int;
        $A = ($A / 2).Int;
        $B = ($B * 2).Int;
        last if $A < 1;
        say "$A, $B";
    }

    say "\nNow to find the product, simply add all the numbers on right side of ','.";
    say "But skip those numbers which have an even number on the left side.\n";

    my Int $product = 0;
    for %sets.sort({.key.Int}).reverse -> $pair {
        if $pair.key % 2 != 0 {
            $product += $pair.value;
            say "- Adding ", $pair.value, " to product.";
        } else {
            say "- Skipping ", $pair.value, " because ", $pair.key, " is even.";
        }
    }

    say "\nProduct: $product";
}
