#!/usr/bin/env perl
use v5.40;

sub doubleDouble($str) {
  # find doubled words and wrap them
  $str =~ s/\b(\w+)\b((?:<[^>]+>|\s|\n)+)\b(\1)\b/\[$1\]$2\[$3\]/i;

  # strip away lines that were not changed
  $str =~ s/^[^\[]+\n//g; # lines starting
  $str =~ s/\n[^\[]+$//g; # lines ending
  $str =~ s/^[^\[]+$//g;  # no subs
  $str;
}

sub displayNewlines($str) {
  (my $copy = $str) =~ s/\n/\\n/g; $copy;
}

sub solution($str) {
  say qq/Input: \$str = "@{[displayNewlines($str)]}"/;
  say qq/Output: "@{[displayNewlines(doubleDouble($str))]}"/;
}

say "Example 1:";
solution("you're given the job of checking the pages on a\nweb server for doubled words (such as 'this this'), a common problem\nwith documents subject to heavy editing.");

say "\nExample 2:";
solution("Find doubled words despite capitalization differences, such as with 'The\nthe...', as well as allow differing amounts of whitespace (spaces,\ntabs, newlines, and the like) to lie between the words.");

say "\nExample 3:";
solution("to make a word bold: '...it is <B>very</B> very important...'.");

say "\nExample 4:";
solution("Perl officially stands for Practical Extraction and Report Language, except when it doesn't.");

say "\nExample 5:";
solution("There's more than one one way to do it.\nEasy things should be easy and hard things should be possible.");
