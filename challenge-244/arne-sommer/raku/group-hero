#! /usr/bin/env raku

unit sub MAIN (*@nums where @nums.elems > 0 && all(@nums) ~~ Int,
               :v(:$verbose));

my $group = 0;
my $total = 0;

for @nums.combinations(1..Inf) -> @candidate
{
  my $max = @candidate.max;
  my $min = @candidate.min;
  my $sum = $max ** 2 * $min;

  $total += $sum;

  say ": Group { ++$group }: ({ @candidate.join(",") }) => square(max({ @candidate.join(",") })) * min({ @candidate.join(",") }) => { $max ** 2 } * $min => $sum" if $verbose;
}

say $total;