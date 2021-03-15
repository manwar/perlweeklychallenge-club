#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say state);
use Test::More;

## This is the first 92 elements of the FUSC sequence for use
## in testing...

## We will write this in four ways....

## As a recursive function to return each of the terms...
## As a simple function which generate values into an array
## For both methods we also add a cacheing version using
## a state variable for the cache.

my @K = (0, 1, 1, 2, 1, 3, 2, 3, 1, 4, 3, 5, 2, 5, 3, 4, 1, 5,
         4, 7, 3, 8, 5, 7, 2, 7, 5, 8, 3, 7, 4, 5, 1, 6, 5, 9,
         4, 11, 7, 10, 3, 11, 8, 13, 5, 12, 7, 9, 2, 9, 7, 12,
         5, 13, 8, 11, 3, 10, 7, 11, 4, 9, 5, 6, 1, 7, 6, 11,
         5, 14, 9, 13, 4, 15, 11, 18, 7, 17, 10, 13, 3, 14, 11,
         19, 8, 21, 13, 18, 5, 17, 12, 19);

subtest 'fusc' => sub {
  is( fusc($_),               $K[$_]             ) foreach 0..@K-1;
  done_testing();
};

subtest 'fusc_cache' => sub {
  is( fusc($_),               $K[$_]             ) foreach 0..@K-1;
  done_testing();
};

## Test all 3 subroutines..
subtest 'fusc_seq' => sub {
  is( join(' ',fusc_seq($_)), join ' ',@K[0..$_-1] ) foreach 0..@K-1;
  done_testing();
};

subtest 'fusc_seq_cache' => sub {
  is( join(' ',fusc_seq_cache($_)), join ' ',@K[0..$_-1] ) foreach reverse 0..@K-1;
  done_testing();
};

done_testing();

## Print the requested string....
say join ' ',map { fusc($_)          } 0..49;
say join ' ',map { fusc_cache($_)    } 0..49;
say join ' ',      fusc_seq(           50);
say join ' ',      fusc_seq_cache(     50);

## Recursive solution....

sub fusc {
  my $n = int shift; ## We int here in case parameter passed in
                     ## isn't an integer (and saves us "int"ing
                     ## in the function calls themselves)
                     ## Both look the floor $n/2 value, but when
                     ## odd also looks at ceil $n/2.
  return $n<2 ? $n : fusc($n/2) + ( $n%2 ? fusc($n/2+1) : 0 );
}

sub fusc_cache {     ## Same method but with cache
  my $n = int shift;
  state @cache;
  return $cache[$n] ||= $n<2 ? $n :
    fusc_cache($n/2) + ( $n%2 ? fusc_cache($n/2+1) : 0 );
}

## Sequence non recursive version!

sub fusc_seq {
  my $n = shift;
  return 0..$n-1 if $n<2;
  my @seq = (0,1,1); ## We need to use one more seed value as the 4th
                     ## entry when we push it needs the 3rd one already
                     ## defined as we are pushing two at a time...

  ## We can simplify the code by pushing two entries onto the list each
  ## time...
  push @seq, $seq[$_]+$seq[$_+1], $seq[$_+1] foreach 1..$n/2-1;

  ## and if odd we just remove the last one we added...
  pop @seq unless $n%2;
  return @seq;
}

## Added ac caching version - this time we remember the list using a
## state variable - and use array slice operator to return the part
## required (if cache bigger than requested sequence)
sub fusc_seq_cache {
  my $n = shift;
  state  @seq = (0,1,1);
  push   @seq, $seq[$_]+$seq[$_+1], $seq[$_+1] foreach @seq/2..$n/2-1;
  return @seq[0..$n-1];
}
