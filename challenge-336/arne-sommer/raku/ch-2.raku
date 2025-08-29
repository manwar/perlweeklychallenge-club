#! /usr/bin/env raku

unit sub MAIN (*@scores where @scores.elems > 0,
               :v(:$verbose));

my @processed;
my $round = 1;

for @scores -> $score
{
  given $score
  {
    when Int   { @processed.push: $score; }
    when '+'   { @processed.push: @processed[*-1] + @processed[*-2]; }
    when 'C'   { @processed.pop; }
    when 'D'   { @processed.push: @processed[*-1] * 2; }
    default    { die "Illegal score $score"; }
  }
  say ": Round { $round++ }: Value:$score -> Scores: { @processed.join(",") }" if $verbose;
}

say @processed.sum;