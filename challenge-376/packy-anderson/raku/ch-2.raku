#!/usr/bin/env raku
use v6;

sub doubleDouble($str is copy) {
  # find doubled words and wrap them
  $str ~~ s:i/<?wb>(\w+)<?wb>
  ([ \< <-[\>]>+ \> | \s | \n ]+)
  {}<?wb>(\w+)<?{$0.fc eq $2.fc}><?wb>/\[$0\]$1\[$2\]/;

  # strip away lines that were not changed
  $str ~~ s:g/^  <-[\[]>+ \n//; # lines starting
  $str ~~ s:g/\n <-[\[]>+  $//; # lines ending
  $str ~~ s:g/^  <-[\[]>+  $//; # no subs
  $str;
}

sub displayNewlines($str is copy) {
  $str ~~ s:g/\n/\\n/; $str;
}

sub solution($str) {
  say qq/Input: \$str = "{displayNewlines($str)}"/;
  say qq/Output: "{displayNewlines(doubleDouble($str))}"/;
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
