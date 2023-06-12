#! /usr/bin/env raku

unit sub MAIN (*@words where @words.elems > 1 && all(@words) ~~ /^<[a..zA..Z]>+$/, :v(:$verbose));

my $set = [(&)] @words>>.lc>>.comb;

say ":Set: { $set.raku }" if $verbose;

say '(' ~ $set.keys.sort.map({ '"' ~ $_ ~ '"' }).join(", ") ~ ')';
