#! /usr/bin/env raku

unit sub MAIN (UInt $limit = 100);

my $ap := (1..Inf).grep( { .is-prime && .comb.sum.is-prime } );

my @ap;

loop
{
  state $index = 0;
  my $current  = $ap[$index++];
  last if $current > $limit;
  @ap.push: $current;
}
  
@ap.join(", ").say;
