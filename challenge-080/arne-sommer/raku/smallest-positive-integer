#! /usr/bin/env raku

unit sub MAIN (*@N where @N.elems > 0 && all(@N) ~~ Int, :v(:$verbose));

my @positively_sorted = @N.grep( * > 0 ).sort.squish;

say ": Positively Sorted: { @positively_sorted.join(", ") }" if $verbose;

my $expected = 1;

for @positively_sorted -> $current
{
  say ": Current value: $current - expected $expected" if $verbose;
  last if $current != $expected;
  $expected++;
}

say $expected;