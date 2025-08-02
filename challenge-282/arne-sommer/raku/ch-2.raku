#! /usr/bin/env raku

unit sub MAIN ($str where $str ~~ /^<[a..z A..Z]>+$/, :v(:$verbose));

my @letters = $str.comb;
my $first   = @letters.shift;
my $count   = 0;

while @letters
{
  my $second = @letters.shift;

  my $change = $first.lc ne $second.lc;

  say ": $first -> $second : { +$change } key change" if $verbose;

  $count++ if $change;

  $first = $second;
}

say $count;