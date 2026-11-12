#!/usr/bin/env raku
use v6;

sub substrings($str) { ($str ~~ m:g/((.)$0*)/).map: *.Str; }

sub shiftRight($i, @str) {
  # replace the first character of the ($i+1)th string
  # with the first character of the ($i)th string
  shiftChar($i, "r", @str)
}

sub shiftLeft($i, @str) {
  # replace the last character of the ($i)th string
  # with the first character of the ($i+1)th string
  shiftChar($i, "l", @str)
}

sub shiftChar($i, $dir, @str) {
  my $newstr;
  my $s = $dir eq "r" ?? $i !! $i-1;
  for 0..$s -> $j { $newstr ~= @str[$j]; }
  if ($dir eq "r") {
    $newstr ~= @str[$i].substr(0,1) ~ @str[$i+1].substr(1);
  }
  else {
    $newstr ~= @str[$i].substr(1) ~ @str[$i+1].substr(0,1);
  }
  for $i+2..@str.end -> $j { $newstr ~= @str[$j]; }
  $newstr;
}

sub longestRepeatingCharacter($str, $k) {
  # gather the substrings
  my @subs = substrings($str);

  # no more substitutions or only one substring
  if ($k == 0 || @subs.elems == 1) {
    return @subs.map(*.chars).max;
  }

  # make new substrings recursively
  my (%longest, $newstr);
  for 0..(@subs.end -1) -> $i {
    $newstr = shiftRight($i, @subs);
    %longest{$newstr} = longestRepeatingCharacter($newstr, $k-1);
    $newstr = shiftLeft($i, @subs);
    %longest{$newstr} = longestRepeatingCharacter($newstr, $k-1);
  }
  %longest.values.max;
}

sub solution($str, $k) {
  say qq/Input: \$str = "$str", \$k = $k/;
  my $len = longestRepeatingCharacter($str, $k);
  say 'Output: ' ~ $len;
}

say "Example 1";
solution("AAAAA", 2);

say "\nExample 2";
solution("ABCDE", 4);

say "\nExample 3";
solution("AAABBBBAA", 1);

say "\nExample 4";
solution("ABACADA", 2);

say "\nExample 5";
solution("BAAABAAAA", 1);
