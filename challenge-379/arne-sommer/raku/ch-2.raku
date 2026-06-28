#! /usr/bin/env raku

unit sub MAIN (UInt :$base where 36 >= $base >= 2,
               UInt :$limit where $limit > 0 = 1000,
               :l(:$loquacious),
               :v(:$verbose) = $loquacious);

my @result;

for 0 .. $limit -1 -> $i
{
  my $in-base      = $i.base($base);
  my $sum          = $in-base.comb.map({ $_.parse-base($base) ** $in-base.chars }).sum;
  my $is-armstrong = $i eq $sum;

  say ": $i (base $base) -> $in-base -> $sum { $is-armstrong ?? "yes" !! "no" }"
    if $loquacious || ($verbose && $is-armstrong); 

  @result.push: $i if $is-armstrong;
}

say "(" ~ @result.join(", ") ~ ")";
