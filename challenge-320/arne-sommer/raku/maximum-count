#! /usr/bin/env raku

unit sub MAIN (*@ints where @ints.elems > 1 && all(@ints) ~~ Int,
               :v(:$verbose));

my $pos = @ints.grep( * > 0 ).elems;
my $neg = @ints.grep( * < 0 ).elems;

say ": There are $pos positive integers\n: There are $neg negative integers" if $verbose;

say ($pos, $neg).max;
