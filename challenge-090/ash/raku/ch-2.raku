#!/usr/bin/env raku
#
# Task 2 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-090/

# Test run:
# $ raku ch-2.raku 150 165
# 150   &   165
# 75    &   330     +
# 37    &   660     +
# 18    &   1320
# 9     &   2640    +
# 4     &   5280
# 2     &   10560
# 1     &   21120   +
# Ethiopian Multiplication: 24750
# Regular multiplication: 24750

unit sub MAIN(Int $a is copy = 14, Int $b is copy = 12);

my $check-product = $a * $b;

my $product = 0;
current-step();

while $a != 1 {
    $a div= 2;
    $b *= 2;

    current-step();
}

say "Ethiopian Multiplication: $product";
say "Regular multiplication: $check-product";

sub current-step() {
    if $a %% 2 {
        say "$a\t&\t$b";
    }
    else {
        say "$a\t&\t$b\t+";
        $product += $b;
    }
}