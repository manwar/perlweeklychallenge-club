#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese);

my @TESTS = (
 [ [qw(peon          perl raku    python)], 2 ],
 [ [qw(goat          love hate    angry )], 3 ],
 [ [qw(accommodation come nation  delta )], 4 ],
 [ [qw(accommodation come country delta )], 0 ],
);

sub word_stickers {
  my( %f, %s, $k, $n, $l, $x );
  $f{$_}++ for split //, shift;
  my @q = [ 1, 0, my %t = %f ];
  map { delete $t{$_} } split // for @_;
  return 0 if keys %t;
  while( ( $n, $l, %f ) = @{ shift @q } ) {
    push @q, map {
      $x = 0, %t = %f;
      exists $t{$_} && ( $x=1, --$t{$_} || delete $t{$_} )
        for split//, $_[$_];
      !%t ? return $n : $x ? [ $n+1, $_, %t ] : ()
    } $l..$#_;
  }
}

is(      word_stickers(        @{$_->[0]} )    , $_->[1] ) for @TESTS2;
done_testing();

sub word_stickers_with_comments {
  my( %f, %s, $k, $n, $l, $x );
  $f{$_}++ for split //, shift; # count for letters
  my %t = %f; # Check all letters on stickers
  # Initialise queue - no stickers, initial freq.
  my @q = [ 1, 0, my %t = %f ]; # Check can solve?
  map { delete $t{$_} } split // for @_;
  return 0 if keys %t; # if not return 0
  my @q = [ 1, 0, %f ]; # [ $no+1, $last, %freqs ]
  while( ($n,$l,%f) = @{ shift @q } ) {
    push @q, map {
      # Make copy of frequencies, set flag ($x)
      # true once we use a letter on sticker,
      # remove letters we have used up
      $x = 0, %t = %f;
      exists $t{$_} && ( $x=1, --$t{$_} || delete $t{$_} )
        for split//, $_[$_];
      # If none left return $n OR push entry onto
      # queue, increasing count and setting new last
      !%t ? return $n : $x ? [ $n+1, $_, %t ] : ()
      # Loop from last used to remove duplicates
    } $l..$#_;
  }
}
