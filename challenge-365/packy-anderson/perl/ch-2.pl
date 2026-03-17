#!/usr/bin/env perl
use v5.40;

sub tokenValid($token) {
  $token =~ /^(?:\p{Ll}+\-)?\p{Ll}+[!.,]?$/
}

sub validTokenCount($str) {
  scalar ( grep { tokenValid($_) } split /\s+/, $str )
}

sub solution($str) {
  say qq/Input: \$str = "$str"/;
  say qq/Output: @{[validTokenCount($str)]}/;
}

say "Example 1:";
solution("cat and dog");

say "\nExample 2:";
solution("a-b c! d,e");

say "\nExample 3:";
solution("hello-world! this is fun");

say "\nExample 4:";
solution("ab- cd-ef gh- ij!");

say "\nExample 5:";
solution("wow! a-b-c nice.");
