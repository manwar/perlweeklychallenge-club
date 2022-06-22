#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # ∅ ≡ ∩ ≢
use v6.d;

=begin comment
Task 1: Primorial Numbers     Submitted by: Mohammad S Anwar

Generate the first 10 Primorial Numbers or primal factorials.
P(0) = 1    (1)
P(1) = 2    (1x2)
P(2) = 6    (1x2×3)
P(3) = 30   (1x2×3×5)
P(4) = 210  (1x2×3×5×7)

=end comment

my constant @prime = gather for 1, 2, 3, 5, 7 … ∞ { .is-prime and .&take};
my constant @primordial = lazy gather for 0 … ∞ { take [×] @prime[0..^ $_]};

.say for @primordial[0 ..^ 10];
