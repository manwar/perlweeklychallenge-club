#! /usr/bin/env raku

unit sub MAIN (*@num where @num.elems > 0 && all(@num) ~~ Numeric,
                :v(:$verbose));

my @sorted = @num.sort;
my $difference;

say ":Sorted: { @sorted.join(", ") }";

for 0 .. @sorted.end - 1 -> $i
{
  my $d = @sorted[$i+1] - @sorted[$i];

  if $i == 0
  {
    $difference = $d;
    say ":Initial difference $d" if $verbose;
  }
  else
  {
    if $difference != $d
    {
      say False;
      exit;
    }
  }
}

say True;