#!/usr/bin/perl

use strict;
use warnings;

my $string = q(
The award-winning adaptation of the classic romantic tragedy "Romeo and Juliet". The feuding families become two warring New York City gangs, the white Jets led by Riff and the Latino Sharks, led by Bernardo. Their hatred escalates to a point where neither can coexist with any form of understanding. But when Riff's best friend (and former Jet) Tony and Bernardo's younger sister Maria meet at a dance, no one can do anything to stop their love. Maria and Tony begin meeting in secret, planning to run away. Then the Sharks and Jets plan a rumble under the highway--whoever wins gains control of the streets. Maria sends Tony to stop it, hoping it can end the violence. It goes terribly wrong, and before the lovers know what's happened, tragedy strikes and doesn't stop until the climactic and heartbreaking ending.
);

print_words( get_words( $string ));

sub get_words {
  my $string = shift;
  my $words = {};
  foreach ( grep {$_ }map { s{([."\(\),]|--|'s$)}{}msgr } $string =~ m{(\S+)}mxg ) {
    $words->{lc $_} ||= [ $_, 0 ];
    $words->{lc $_}[1]++;
  }
  return $words;
}

sub print_words {
  my $struct = shift;
  my @words;
  ## Use array rather than hash as avoids one of the two sorts and
  ## shouldn't be too sparse
  push @{ $words[$_->[1]] }, $_->[0] foreach (values %{$struct});
  foreach ( 0..(@words-1) ) {
    next unless $words[$_];
    print "$_ @{[ sort { lc $a cmp lc $b } @{$words[$_]} ]}\n";
  }
}




