#! /usr/bin/env raku

unit sub MAIN (*@list where @list.elems > 1, :v(:$verbose));

my $half   = Int(@list.elems / 2);
my @sorted = @list.sort.reverse;
my @low    = @sorted[$half .. Inf];
my @high   = @sorted[^$half];

if $verbose
{
  say ":Sorted: @sorted[]";
  say ":Lower half: @low[]";
  say ":Higher half: @high[]";
}

say "(", roundrobin(@low, @high).flat.join(","), ")";
