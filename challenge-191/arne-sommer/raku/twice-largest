#! /usr/bin/env raku

unit sub MAIN (*@list where @list.elems > 0 && all(@list) ~~ Int, :v(:$verbose));

my @sorted  = @list.sort;

say ":Sorted: @sorted[]" if $verbose;

my $largest = @sorted.pop;
my $next    = @sorted.pop;

say ":Largest: $largest" if $verbose;
say ":Next: $next" if $verbose;

say ($largest >= $next * 2) ?? 1 !! -1;
