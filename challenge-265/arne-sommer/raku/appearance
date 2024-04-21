#! /usr/bin/env raku

unit sub MAIN (*@ints where all(@ints) ~~ Int && @ints.elems > 0, :v(:$verbose));

my $limit  = @ints.elems * 0.33;
my %freq   = @ints.Bag;
my %ok     = %freq.grep({ $_.value >= $limit });
my @keys   = %ok.keys.sort;

if $verbose
{
  say ": Frequencies: { %freq.raku }";
  say ": Limit: $limit";
  say ": OK: { %ok.raku }";
  say ": Sorted: { @keys.join(",") }";
}

say @keys.first;

