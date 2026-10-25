#! /usr/bin/env raku

unit sub MAIN (*@arr where @arr.elems > 0 && all(@arr) ~~ Int,
               :v(:$verbose));

my $n = @arr.elems;

my @dir = (@arr[0 .. $n - 2] Z<=> @arr[1 .. $n - 1])
          .map: { $_ < 0 ?? "u" !! $_ > 0 ?? "d" !! "=" };

my $m = @dir.join.match(/^ $<p>=<[u]>+ $<d>=<[d]>+ <[u]>+ $/);

if $verbose
{
  if $m
  {
    my $p = $m<p>.chars;
    my $q = $p + $m<d>.chars;
    say ": p = $p, q = $q";
    say ": (@arr[0 .. $p].join(", ")) is strictly increasing";
    say ": (@arr[$p .. $q].join(", ")) is strictly decreasing";
    say ": (@arr[$q .. $n - 1].join(", ")) is strictly increasing";
  }
  else
  {
    my $p-max = @dir.join.match(/^<[u]>*/).chars;
    my $q-min = $n - 1 - @dir.join.match(/<[u]>*$/).chars;
    say ": Increasing prefix ends at index $p-max: (@arr[0 .. $p-max].join(", "))";
    say ": Increasing suffix starts at index $q-min: (@arr[$q-min .. $n - 1].join(", "))";
    say ": No p and q satisfy the conditions";
  }
}

say $m.defined;