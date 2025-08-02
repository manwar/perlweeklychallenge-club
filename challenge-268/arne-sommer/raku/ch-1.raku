#! /usr/bin/env raku

unit sub MAIN ($x, $y, :v(:$verbose));

my @x = $x.words>>.Int.sort;  ## Numeric
my @y = $y.words>>.Int.sort;

die "Not the same length" unless @x.elems == @y.elems;

my @pairs = @x Z @y;

say ":Pairs: { @pairs.raku }" if $verbose;

my @diff = @pairs.map({ $_[0] - $_[1] });

say ":Diff: { @diff.join(", ") }" if $verbose;

say ( [==] @diff ) ?? @diff[0].abs !! 'error';
