#! /usr/bin/env raku

unit sub MAIN (*@list where @list.elems > 0 && all(@list) ~~ /^<[1..9]><[0..9]>*$/);

my $end = @list.elems - 1;

for 0 .. $end - 2 -> $i
{
  for $i + 1 .. $end - 1 -> $j
  {
    for $j + 1 .. $end -> $k
    {
      if @list[$i] < @list[$k] < @list[$j]
      {
        say "(@list[$i], @list[$j], @list[$k])";
	exit;
      }
    }
  }
}

say "()";
