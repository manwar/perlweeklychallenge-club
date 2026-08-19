#!/usr/bin/env raku
use v6;

sub normalizeAtoms($str, $multiplier = 1) {
  my (%atoms, $output);
  my $match = $str ~~ m:g/(<:Lu><:Ll>?)(\d*)/;
  for $match.list -> $m {
    my ($k, $v) = ($m[0], $m[1].Str || 1);
    %atoms{$k} += $v * $multiplier;
  }
  for %atoms.keys.sort -> $k {
    $output ~= %atoms{$k} == 1 ?? $k !! $k ~ %atoms{$k};
  }
  $output;
}

sub atomsCount($formula is copy) {
  # while we have parenthetical groups
  while (my $match = $formula ~~ m/(\(<-[\(\)]>+\)\d+)/) {
    my $orig = $match[0]; # save for later
    # grab values for ($str)$count
    my ($str, $count) = ($orig ~~ /\((.+)\)(\d+)/)[0,1];
    $str = normalizeAtoms($str, $count); # count atoms in string
    $formula ~~ s/$orig/$str/; # replace orig with normalized
  }
  normalizeAtoms($formula); # normalize one more time
}

sub solution($formula) {
  say 'Input: $formula = "' ~ $formula ~ '"';
  say 'Output: "' ~ atomsCount($formula) ~ '"';
}

say "Example 1:";
solution("((N2O)3(H2O)2)2");

say "\nExample 2:";
solution("Mg3(PO4)2");

say "\nExample 3:";
solution("(((H)2)3)4");

say "\nExample 4:";
solution("NaCl3(O2(S10)2)2Mg");

say "\nExample 5:";
solution("Z2Y3(X2W)2");
