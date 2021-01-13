#!/usr/bin/env perl6
use v6;

# run as <script>

sub rep_across_msgs(@a) {
    (roundrobin @a.List).map({ ($_.Bag (-) $_.Set).keys }) 
}

my @a1=(
    <H x l 4 !>,
    <c e - l o>,
    <z e 6 l g>,
    <H W l v R>,
    <q 9 m # o>,
);

my @a2=(
    Q:w{P + 2 l ! a t o},
    Q:w{1 e 8 0 R $ 4 u},
    Q:w{5 - r ] + a > /},
    Q:w{P x w l b 3 k \},
    Q:w{2 e 3 5 R 8 y u},
    Q:w{< ! r ^ ( ) k 0},
);

for (@a1, @a2) {.&rep_across_msgs.say} 
