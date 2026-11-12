#!/usr/bin/env perl
use v5.44;

use List::AllUtils qw( max );

sub substrings($str) {
  # gather the substrings
  my @subs = $str =~ m/((.)\g-1*)/g;

  # keep only the substrings (the first match),
  # not the single char char (the second match)
  @subs[grep { $_ % 2 == 0 } 0..$#subs];
}

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
  # replace the last character of the ($i)th string
  # with the first character of the ($i+1)th string
  my $newstr;
  my $s = $dir eq "r" ? $i : $i-1;
  for my $j ( 0..$s ) { $newstr .= $str[$j]; }
  if ($dir eq "r") {
    $newstr .= substr($str[$i],0,1) . substr($str[$i+1],1);
  }
  else {
    $newstr .= substr($str[$i],1) . substr($str[$i+1],0,1);
  }
  for my $j ( $i+2..$#str ) { $newstr .= $str[$j]; }
  $newstr;
}

sub longestRepeatingCharacter($str, $k) {
  # gather the substrings
  my @subs = substrings($str);

  # no more substitutions or only one substring
  if ($k == 0 || @subs == 1) {
    return max map { length($_) } @subs;
  }

  # make new substrings recursively
  my (%longest, $newstr);
  for my $i ( 0..($#subs -1) ) {
    $newstr = shiftRight($i, @subs);
    $longest{$newstr} = longestRepeatingCharacter($newstr, $k-1);
    $newstr = shiftLeft($i, @subs);
    $longest{$newstr} = longestRepeatingCharacter($newstr, $k-1);
  }
  max values %longest;
}

sub solution($str, $k) {
  say qq/Input: \$str = "$str", \$k = $k/;
  my $len = longestRepeatingCharacter($str, $k);
  say 'Output: ' . $len;
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
