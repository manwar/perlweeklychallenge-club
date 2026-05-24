#!/usr/bin/env perl
use v5.40;

sub wordBreak($str, @words) {
  for my $word (@words) {
    $str =~ s/$word/ /g;
  }
  $str =~ /\A\s*\z/ ? 'true' : 'false';
}

sub solution($str, $words) {
  my $wordlist = join(", ", map { qq/"$_"/ } @$words);
  say qq/Input: \$str = '$str', \@words = ($wordlist)/;
  say 'Output: ' . wordBreak($str, @$words);
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
