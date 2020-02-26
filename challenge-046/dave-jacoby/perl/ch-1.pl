#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ postderef say signatures state switch };
no warnings
  qw{ experimental::postderef experimental::smartmatch experimental::signatures };

my $str1 = q{
H x l 4 !
c e - l o
z e 6 l g
H W l v R
q 9 m # o
};

my $str2 = q{
P + 2 l ! a t o
1 e 8 0 R $ 4 u
5 - r ] + a > /
P x w l b 3 k \
2 e 3 5 R 8 y u
< ! r ^ ( ) k 0
};

for my $ctext ( $str1, $str2 ) {
    my $ptext = decypher($ctext);
    say $ptext;
}

sub decypher ( $ctext ) {
    # ctext = cyphertext, ptext = plaintext. common terms in cryptography.

    # this breaks the message into a two-dimensional array
    my @ctext = map { [ split /\s+/, $_ ] } grep { /\S/ } split m{\n}, $ctext;
    my @ptext;

    # for each row, we get every entry, and then use a hash to count
    # the times that each show up
    # then we pull the key with the max usage, push it into the
    #   plaintext array and join it and return it.
    for my $i ( 0 .. scalar $ctext[0]->@* - 1 ) {
        my %col;
        map { $col{ $_->[$i] }++ } @ctext;
        my ($k) = sort { $col{$b} <=> $col{$a} } keys %col;
        push @ptext, $k;
    }
    return join '', @ptext;
}
