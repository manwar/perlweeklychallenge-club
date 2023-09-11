#! /usr/bin/env raku

unit sub MAIN (*@ints where @ints.elems > 1 && all(@ints) ~~ Int);

my $bag = @ints.Bag;

say "(", $bag.sort({ $^a.value <=> $^b.value || $^b.key <=> $^a.key }).map({ $_.key xx $_.value }).flat.join(","), ")";

