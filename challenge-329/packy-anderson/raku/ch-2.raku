#!/usr/bin/env raku
use v6;

sub swapCase($l) {
  return $l.lc eq $l ?? $l.uc !! $l.lc;
}

sub niceString($str is copy) {
  # convert the string to a Bag so we
  # know which characters are in it
  my $seen = Bag.new: $str.comb;

  # loop through the letters and make a list
  # of those that only appear in one case
  my @notBothCases;
  for $seen.keys -> $l {
    next if swapCase($l) ∈ $seen;
    @notBothCases.push($l);
  }

  # build a regex of the characters we're removing
  my $replace = '<[' ~ @notBothCases.join(' ') ~ ']>+';

  # replace those characters with space
  $str ~~ s:g/<$replace>/ /;

  # get rid of leading and trailing whitespace
  $str.=trim;

  # split on whitespace
  my @substrings = $str.split(/\s+/);

  # loop through the substrings we've found and find the longest
  my $longest = '';
  for @substrings -> $s {
    $longest = $s if $s.chars > $longest.chars;
  }

  return $longest;
}

sub solution($str) {
  say qq{Input: \$str = "$str"};
  say 'Output: "' ~ niceString($str) ~ '"';
}

say "Example 1:";
solution("YaaAho");

say "\nExample 2:";
solution("cC");

say "\nExample 3:";
solution("A");

say "\nExample 4:";
solution("AaBcDEFdefGhIiJjKlm");
