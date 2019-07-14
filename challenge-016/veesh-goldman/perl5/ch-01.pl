#! /usr/bin/env perl

use v5.22;
#TASK: given a pie of pizza (computer people think of everything
#in terms of pizza) shared between 100 guests, where the first
#gets 1%, and the next gets 2% of what remains, etc: who gets the
#biggest piece?

my $guests = shift // 100;
my $biggest = {};

sub cut_a_slice_for {
  state $pie = 1;
  my $slice = (shift() / $guests ) * $pie;
  $pie -= $slice;
  return $slice
}

for my $guest ( 1 .. $guests ) {
  my $piece = cut_a_slice_for($guest); 
  $biggest = { name => $guest, size => $piece } if $piece > $biggest->{size}
}

say $biggest->{name}
