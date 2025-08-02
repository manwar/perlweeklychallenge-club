#! /usr/bin/env raku

unit sub MAIN ($str where $str.chars > 1, :v(:$verbose));

my $adjacents := gather
{
  my @str = $str.comb;

  my $first = @str.shift;

  while @str.chars
  {
    my $second = @str.shift;

    take ($first, $second);

    $first = $second;
  }
}

my $score = 0;

for $adjacents -> @pair
{
  my $first  = @pair[0];
  my $second = @pair[1];

  my $first_code  = $first.ord;
  my $second_code = $second.ord;
  my $difference  = abs ($first_code - $second_code);

  $score += $difference;

  say ": Adjacents: '$first' ($first_code) - '$second' ($second_code) = $difference -> $score" if $verbose;
}

say $score;
