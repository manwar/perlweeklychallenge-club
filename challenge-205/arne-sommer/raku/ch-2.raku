#! /usr/bin/env raku

unit sub MAIN (*@array where @array.elems >= 2 && all(@array) ~~ /^<[0..9]>*$/, :v(:$verbose));

my @unique = @array.unique;
my $end    = @unique.end;
my $max    = -Inf;

say ": Unique: @unique[]" if $verbose;

for 0 .. $end - 1 -> $left
{
  for $left + 1 .. $end -> $right
  {
    my $xor = @unique[$left] +^ @unique[$right];
    say ": @unique[$left] xor @unique[$right] -> $xor { "max" if $  }" if $verbose;
    $max = max($max, $xor);
  }
}

say $max;