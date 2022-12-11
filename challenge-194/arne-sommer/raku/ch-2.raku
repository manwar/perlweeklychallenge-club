#! /usr/bin/env raku

subset az where /^<[a..z]>+$/;

unit sub MAIN (az $s, :v(:$verbose));

my @freq = $s.comb.Bag.values.sort;

say ": Frequency sorted: @freq[]" if $verbose;

@freq.push(@freq.pop - 1);

say ": Frequency lowered: @freq[]" if $verbose;

say ( [==] @freq ) ?? 1 !! 0;
