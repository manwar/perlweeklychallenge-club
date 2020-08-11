#! /usr/bin/env raku

use MONKEY-SEE-NO-EVAL;

unit sub MAIN (:$verbose, :$all);

my $input = "123456789";

for ^Inf
{
  my $ternary = .base(3).fmt('%08d');

  last if $ternary.chars > 8;

  print ": $input ~ $ternary" if $verbose;

  my $string = (roundrobin $input.comb, $ternary.comb.map({ conv($_) })).flat.join;

  say " -> $string" if $verbose;

  if (EVAL $string) == 100
  {
    say "100 == $string";
    exit unless $all;
  }
}

sub conv ($char)
{
  return ""  if $char eq "0";
  return "+" if $char eq "1";
  return "-" if $char eq "2";
}
