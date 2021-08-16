#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @grid = qw(x***x*xxxx *********x ****x*x*x* ***xx***** x***x****x);

say join "\n",'',@grid,'';
print solve(@grid);
say '';

sub solve {
  my @res = ('');
  ## Map input of strings into an array of 1s (bombs) + 0s (spaces)
  my @in = map { [ map { $_ eq 'x' ? 1:0 } split //, $_ ] } @_;

  ## Get index of last row or column...
  my( $h, $w ) = ( $#_, -1 + length $_[0] );

  foreach my $y ( 0 .. $h ) {
    $res[-1] .= $in[$y][$_] ? 'x' :
     ( $y      ? ( $_ ? $in[$y-1][$_-1] : 0 ) + $in[$y-1][$_] + ( $_ < $w ? $in[$y-1][$_+1] : 0 ) : 0 ) +
                 ( $_ ? $in[$y  ][$_-1] : 0 ) + $in[$y  ][$_] + ( $_ < $w ? $in[$y  ][$_+1] : 0 )       +
     ( $y < $h ? ( $_ ? $in[$y+1][$_-1] : 0 ) + $in[$y+1][$_] + ( $_ < $w ? $in[$y+1][$_+1] : 0 ) : 0 ) foreach 0 .. $w;
    push @res, '';
  }
  return join "\n", @res;
}

