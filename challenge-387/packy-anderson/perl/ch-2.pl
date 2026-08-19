#!/usr/bin/env perl
use v5.44;

sub normalizeAtoms($str, $multiplier = 1) {
  my (%atoms, $output);
  while ($str =~ m/(\p{Lu}\p{Ll}?)(\d*)/g) {
    my ($k, $v) = ($1, $2 || 1);
    $atoms{$k} += $v * $multiplier;
  }
  for my $k (sort keys %atoms) {
    $output .= $atoms{$k} == 1 ? $k : $k . $atoms{$k};
  }
  $output;
}

sub atomsCount($formula) {
  # while we have parenthetical groups
  while ($formula =~ m/(\([^\(\)]+\)\d+)/) {
    my $orig = $1; # save for later
    # grab values for ($str)$count
    my ($str, $count) = $orig =~ /\((.+)\)(\d+)/;
    $str = normalizeAtoms($str, $count); # count atoms in string
    $orig = quotemeta($orig); # quote the parens
    $formula =~ s/$orig/$str/; # replace orig with normalized
  }
  normalizeAtoms($formula); # normalize one more time
}

sub solution($formula) {
  say 'Input: $formula = "' . $formula . '"';
  say 'Output: "' . atomsCount($formula) . '"';
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
