#!/usr/bin/env perl6
# Print the Hofstadter male and female sequences
# using mutually recursive functions.

sub M (Int $n) {
    return $n == 0 ?? 0 !! $n - F(M($n-1));
}

sub F (Int $n) {
    return $n == 0 ?? 1 !! $n - M(F($n-1));
}

say "Male   sequence: ", (0..10).map(&M);
say "Female sequence: ", (0..10).map(&F);
