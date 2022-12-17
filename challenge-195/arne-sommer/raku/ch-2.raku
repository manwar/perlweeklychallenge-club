#! /usr/bin/env raku

unit sub MAIN (*@list where @list.elems > 0 && all(@list) ~~ /^<[1..9]><[0..9]>*$/, :v(:$verbose));

my @even = @list.grep: * %% 2;

if @even.elems
{
  my $bag    = @even.Bag;
  my $max    = $bag.values.max;
  my $res    = $bag.grep({ $_.value == $max });
  my @sorted = $res>>.key.sort;

  if $verbose
  {
    say ":Even: @even[]";
    say ":Max: $max";
    say ":Sorted: @sorted[]";
  }

  say @sorted.first;
}
else
{
  say ":No even integers" if $verbose;
  say -1;
}
