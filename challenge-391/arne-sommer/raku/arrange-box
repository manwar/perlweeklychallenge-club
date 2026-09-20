#! /usr/bin/env raku

unit sub MAIN (*@boxes, :v(:$verbose));

my @dims = @boxes>>.words>>.Numeric;

die "At least one box is required" unless @dims.elems;
die "Each box must have exactly two dimensions" unless all(@dims>>.elems) == 2;

my @sorted = @dims.sort: { (.[0], -.[1]) };

if $verbose
{
  say ": Sorted: " ~ @sorted.map({ "[$_[0], $_[1]]" }).join(", ");
  say ": Heights: " ~ @sorted>>[1].join(", ")
}

my @tails;

for @sorted -> $box
{
  my $lo = @tails.first({ .[*-1][1] >= $box[1] }, :k) // @tails.elems;
  @tails[$lo] = $lo > 0 ?? @tails[$lo - 1].Array.append($box) !! [$box];
}

my $chain = @tails[*-1];

say ": Chain: " ~ $chain.map({ "[$_[0], $_[1]]" }).join(" -> ") if $verbose;

say $chain.elems;
