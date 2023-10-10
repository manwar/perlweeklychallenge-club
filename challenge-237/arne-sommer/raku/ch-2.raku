#! /usr/bin/env raku

unit sub MAIN (*@nums where all(@nums) ~~ Int && @nums.elems > 0, :v(:$verbose));

my $count  = 0;

my @sorted = @nums.sort.reverse;

for @sorted.clone -> $num
{
  if $num < @sorted[0]
  {
    $count++;
    say ":Num: $num < Perm: @sorted[*-1] [+]" if $verbose;
    @sorted.shift;
  }
  else
  {
    say ":Num: $num >= Perm: @sorted[0]" if $verbose;
    @sorted.pop;
  }
}

say $count;
