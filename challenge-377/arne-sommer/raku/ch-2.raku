#! /usr/bin/env raku

unit sub MAIN (*@array where @array.elems > 1,
               :v(:$verbose));

my $matches = 0;

for @array.combinations(2) -> ($left, $right)
{
  check-suffix($left, $right);

  next if $left eq $right;

  check-suffix($right, $left);
}

sub check-suffix ($left, $right)
{
  if $left ~~ /^ $right / && $left ~~ / $right $/
  {
    say ": + '$left' has prefix & suffix '$right'" if $verbose;
    $matches++;
  }
  elsif $verbose
  {
    say ":   '$left' does not have prefix & suffix '$right'.";
  }
}

say $matches;