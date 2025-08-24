#! /usr/bin/env raku

unit sub MAIN (*@words where @words.elems > 0, :v(:$verbose));

my @bags  = @words>>.comb>>.Bag;

say ": Bags; { @bags.raku }" if $verbose;

my $intersection = [(&)] @bags;

say ": Common: { $intersection.raku }" if $verbose;

say "(" ~ $intersection.kxxv.sort.map( '"' ~ * ~ '"' ).join(", ") ~ ")";