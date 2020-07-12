#! /usr/bin/env raku

unit sub MAIN (*@list, :$v, :$verbose = $v);

my $half = (@list.elems / 2 -1).ceiling;

if $verbose
{
  say ": Halfway point: Index: $half, value: @list[$half]";
  say ": From the start: ", @list[0..$half];
  say ": From the end:   ", @list[$half +1 .. *].reverse;
  # say ": From the end:   ", @list[*-1 ... $half +1];
}

say (roundrobin @list[0..$half], @list[$half +1 .. *].reverse).flat.join(" -> ");

