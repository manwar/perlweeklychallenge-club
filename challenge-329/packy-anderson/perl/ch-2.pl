#!/usr/bin/env perl
use v5.40;

sub swapCase($l) {
  return lc($l) eq $l ? uc($l) : lc($l);
}

sub niceString($str) {
  # convert the string to a Bag so we
  # know which characters are in it
  my %seen = map { $_ => 1 } split //, $str;

  # loop through the letters and make a list
  # of those that only appear in one case
  my @notBothCases;
  foreach my $l ( keys %seen) {
    next if exists $seen{ swapCase($l) };
    push @notBothCases, $l;
  }

 if (@notBothCases) {
    # build a regex of the characters we're removing
    my $replace = '[' . join('', @notBothCases) . ']+';

    # replace those characters with space
    $str =~ s/$replace/ /g;
 }

  # get rid of leading and trailing whitespace
  $str =~ s/^\s+|\s+$//g;

  # split on whitespace
  my @substrings = split /\s+/, $str;

  # loop through the substrings we've found and find the longest
  my $longest = '';
  foreach my $s ( @substrings ) {
    $longest = $s if length($s) > length($longest);
  }

  return $longest;
}

sub solution($str) {
  say qq{Input: \$str = "$str"};
  say 'Output: "' . niceString($str) . '"';
}

say "Example 1:";
solution("YaaAho");

say "\nExample 2:";
solution("cC");

say "\nExample 3:";
solution("A");

say "\nExample 4:";
solution("AaBcDEFdefGhIiJjKlm");
