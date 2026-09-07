#! /usr/bin/env raku

unit sub MAIN (Str $rat1, Str $rat2, :v(:$verbose));

my ($n1, $d1, $n2, $d2) = flat ($rat1, $rat2)>>.&parse-rat;

if $verbose
{
  say ": $rat1 -> $n1 - $d1";
  say ": $rat2 -> $n2 - $d2";
}

say $n1 * $d2 == $n2 * $d1;

sub parse-rat(Str $s)
{
  my $m = $s ~~ /^ (\d*) \. (\d*) \(? (\d*) \)? $/;

  my ($int, $nonrep, $rep) = ~$m[0], ~$m[1], ~$m[2];

  my ($b, $c) = ($nonrep, $rep)>>.chars;

  return +"$int$nonrep", 10 ** $b unless $c;

  my $full = +"$int$nonrep$rep";

  return $full - +"$int$nonrep", (10 ** $c - 1) * 10 ** $b;
}
