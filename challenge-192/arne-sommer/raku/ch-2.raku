#! /usr/bin/env raku

unit sub MAIN (*@list where @list.elems > 1 && all(@list) ~~ /^\d+/, :v(:$verbose));

my $sum     = @list.sum;
my $target  = $sum div @list.elems;

if $target != $sum / @list.elems
{
  say -1;
  exit;
}

say ":Computing..." if $verbose;

my $moves = 0;

my @list2 = @list.map: +*;

for 0 .. @list2.elems - 2 -> $index
{
  while @list2[$index] > $target
  {
    $moves++;
    @list2[$index]--;
    @list2[$index+1]++;
    say ":Move $moves: @list2[]" if $verbose;
  }

  while @list2[$index] < $target
  {
    $moves++;
    @list2[$index]++;
    @list2[$index+1]--;
    say ":Move $moves: @list2[]" if $verbose;
  }
}

say $moves;
