#! /usr/bin/env raku

unit sub MAIN ($phone where $phone ~~ /^ <[0 .. 9 \s -]>+ $/,
               :v($verbose));

my $parts := gather
{
  my $current = "";
  my @todo = $phone.comb.grep: * eq any(0..9);

  say ": Digits { @todo.join }" if $verbose;

  while @todo
  {
    $current ~= @todo.shift;
  
    if $current.chars == 3 || (@todo.elems == 2 && $current.chars == 2)
    {
      take $current;
      $current = "";
    }
  }

  take $current if $current;
}

say $parts.join("-");

