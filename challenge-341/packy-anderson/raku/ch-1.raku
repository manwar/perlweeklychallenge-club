#!/usr/bin/env raku
use v6;

sub brokenKeys($str, @keys) {
  my @words = $str.comb(/\S+/);
  # if there are no broken keys,
  # we can type all the words
  return @words.elems if @keys == 0;
  # build a character class
  my $regex = '<[' ~ @keys.join ~ ']>';
  # count how many words don't match the class
  return ( ( @words.grep({! /:i <$regex>/ }) ).elems );
}

sub solution($str, @keys) {
  my $keys = @keys.map({"'$_'"}).join(",");
  say "Input: \$str = '$str', \@keys = ($keys)";
  say "Output: " ~ brokenKeys($str, @keys);
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