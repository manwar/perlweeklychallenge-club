#!/usr/bin/env raku

sub common-characters(@arr)
{
  my @letters;
  @arr.map({my %h; %h{$_}++ for $_.comb; @letters.push(%h)});
  @letters[0].keys.map({
  my $letter = $_;
  my $rep = (0..@letters.end).map({@letters[$_]{$letter} // 0}).min;
  $letter x $rep
});
}

say common-characters(["java","javascript","julia"]);
say common-characters(["bella","label","roller"]);
say common-characters(["cool","lock","cook"]);

