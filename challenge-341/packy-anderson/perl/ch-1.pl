#!/usr/bin/env perl
use v5.40;

sub brokenKeys($str, @keys) {
  my @words = split /\s+/, $str;
  # if there are no broken keys,
  # we can type all the words
  return scalar(@words) if @keys == 0;
  # build a character class
  my $regex = '[' . join('', @keys) . ']';
  # count how many words don't match the class
  return ( scalar( grep {! /$regex/i } @words) );
}

sub solution($str, $keys) {
  my $keylist = join ",", map {"'$_'"} @$keys;
  say "Input: \$str = '$str', \@keys = ($keylist)";
  say "Output: " . brokenKeys($str, @$keys);
}

say "Example 1:";
solution("Hello World", ["d"]);

say "\nExample 2:";
solution("apple banana cherry", ["a", "e"]);

say "\nExample 3:";
solution("Coding is fun", []);

say "\nExample 4:";
solution("The Weekly Challenge", ["a","b"]);

say "\nExample 5:";
solution("Perl and Python", ["p"]);