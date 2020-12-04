#! /usr/bin/env raku

unit sub MAIN (:v(:$verbose), :a(:$all));

for (1..9).permutations -> @candidate
{
  say ":: @candidate[]" if $verbose;
  my ($a, $b, $c, $d, $e, $f, $g, $h, $i) = @candidate;

  next unless $a + $b + $c == 15;
  next unless $d + $e + $f == 15;
  next unless $g + $h + $i == 15;
  next unless $a + $d + $g == 15;
  next unless $b + $e + $h == 15;
  next unless $c + $f + $i == 15;
  next unless $a + $e + $i == 15;
  next unless $c + $e + $g == 15;

  say "[ { @candidate[0..2] } ]";
  say "[ { @candidate[3..5] } ]";
  say "[ { @candidate[6..8] } ]";
  say "" if $all;

  last unless $all;
}