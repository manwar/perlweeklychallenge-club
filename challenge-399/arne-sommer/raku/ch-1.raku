#! /usr/bin/env raku

unit sub MAIN (Str $str where $str.chars > 0,
               Int $k where $k > 0,
               :v(:$verbose));

my @chars = $str.comb;
my $best  = 0;
my $left  = 0;
my %count;

for ^ @chars.elems -> $right
{
  %count{@chars[$right]}++;

  while $right - $left + 1 - %count.values.max > $k
  {
    %count{@chars[$left]}--;
    $left++;
  }

  my $window    = @chars[$left .. $right].join;
  my $max-count = %count.values.max;
  my $letter    = %count.keys.first: { %count{$_} == $max-count };
  my $changes   = $window.chars - $max-count;

  if $verbose
  {
    say ": \"$window\" — $max-count x $letter, $changes replacement"
        ~ ($changes == 1 ?? '' !! 's');
  }

  $best = max($best, $window.chars);
}

say $best;