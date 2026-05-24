#!/usr/bin/env raku
use v6;

sub wordBreak($str is copy, @words) {
  for @words -> $word {
    $str ~~ s:g/$word/ /;
  }
  $str ~~ /^\s*$/ ?? 'true' !! 'false';
}

sub solution($str, @words) {
  my $words = @words.map({ qq/"$_"/ }).join(", ");
  say qq/Input: \$str = '$str', \@words = ($words)/;
  say 'Output: ' ~ wordBreak($str, @words);
}

say "Example 1:";
solution("weeklychallenge", ["challenge", "weekly"]);

say "\nExample 2:";
solution("perlrakuperl", ["raku", "perl"]);

say "\nExample 3:";
solution("sonsanddaughters", ["sons", "sand", "daughters"]);

say "\nExample 4:";
solution("raperlrakuperlku", ["raku", "perl"]);

say "\nExample 5:";
solution("thequickbrownfoxx", ["the", "quick", "brown", "fox"]);
