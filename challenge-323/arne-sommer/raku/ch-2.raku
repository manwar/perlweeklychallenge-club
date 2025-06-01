#! /usr/bin/env raku

unit sub MAIN (UInt $income is copy, *@tax-brackets where @tax-brackets.elems > 0,
               :v(:$verbose));

my @tax = @tax-brackets>>.words;

my @limits   = @tax[*;0]>>.Numeric;
my @percents = @tax[*;1]>>.Numeric;

die "Overlapping brackets" unless [<] @limits;

die "Wrong percentage values (0..100 only)" unless all(@percents) ~~ Numeric
       && all(@percents) >= 0
       && all(@percents) <= 100;

my $i   = 0;
my $tax = 0;

for @tax -> ($at, $pct)
{
  last if $income <= 0;

  my $bracket = $at - $i;
  my $add = min($bracket, $income) * $pct / 100;

  say ": Add [{ $i +1 } .. $at]: $bracket @ $pct% = $add" if $verbose;

  $i = $at;

  $tax += $add;
  $income -= $bracket;
}

say $tax;