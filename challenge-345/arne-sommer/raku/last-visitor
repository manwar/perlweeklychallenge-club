#! /usr/bin/env raku

unit sub MAIN (*@ints where @ints.elems > 0 && all(@ints) ~~ Int,
		:v(:$verbose));

my @seen;
my @ans;

my $x = 0;

for @ints -> $int
{
  if $int > 0
  {
    $x = 0;
    @seen.unshift: $int;
  }
  elsif $int == -1
  {
    if $x < @seen.elems
    {
      @ans.push: @seen[$x];
    }
    else
    {
      @ans.push: -1;
    }
    $x++;
  }
  else
  {
    die "Illegal value $int (legal values: -1,1,2,3,..)";
  }
  say ": $int -> seen: { @seen.join(",") } ans: { @ans.join(",") }" if $verbose;
}

say "({ @ans.join(",") })";