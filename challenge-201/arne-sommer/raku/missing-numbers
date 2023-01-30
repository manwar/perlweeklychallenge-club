#! /usr/bin/env raku

unit sub MAIN (*@array where @array.elems && all(@array) ~~ /^<[0..9]>*$/, :v(:$verbose));

my $n       = @array.elems;
my @sorted  = @array.sort;
my @missing = ();
my $current = @sorted.shift;

for 0 .. $n -> $i
{
  say ": Checking $i" if $verbose;

  $current == $i
    ?? ( $current = @sorted.shift || next )
    !! ( @missing.push: $i                );
}

say @missing.join(",");

