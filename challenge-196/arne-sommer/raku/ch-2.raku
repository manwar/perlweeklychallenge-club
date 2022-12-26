#! /usr/bin/env raku

unit sub MAIN (*@array where @array.elems > 1 && all(@array) ~~ /^<[0..9]>+$/ && [<] @array);

my @ranges;
my $from = @array.shift.Int;
my $to   = $from;

while @array
{
  my $next = @array.shift.Int;
  if $next == $to + 1
  {
    $to = $next;
  }
  else
  {
    @ranges.push([$from, $to]) if $to > $from;
    $from = $to = $next;
  }
}

@ranges.push([$from, $to]) if $to > $from;

say @ranges.raku;
