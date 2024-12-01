#! /usr/bin/env raku

subset BinaryDigit of Int where * eq any(0,1);

unit sub MAIN (*@binary where @binary.elems >= 1 && all(@binary) ~~ BinaryDigit,
               :v(:$verbose));

my $end = @binary.end;
my $max = 0;

for 0 .. $end -> $start
{
  for $end ... $start -> $stop
  {
    my $size    = $stop - $start + 1;

    say ": Slice: [$start..$stop] Size: $size Values: ({ @binary[$start..$stop].join(",") })" if $verbose;

    if $size <= $max
    {
      say ": - Skipping the rest of the inner loop (size too small)" if $verbose;
      last;
    }
    
    unless $size %% 2
    {
      say ": - Uneven size ($size) - Skipped" if $verbose;
      next;
    }

    my $equal   = $size == @binary[$start..$stop].sum * 2;

    if $equal && $size > $max
    {
      $max = $size;
      say ": - Equal -> New Maximum: $max" if $verbose;
    }
    elsif $verbose
    {
      say ": - Equal: $equal";
    }
  }
}

say $max;
