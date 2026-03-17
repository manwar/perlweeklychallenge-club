#!/usr/bin/env raku
use v6;

sub tokenValid($token) {
  $token ~~ /^[<:Ll>+\-]?<:Ll>+<[!.,]>?$/
}

sub validTokenCount($str) {
  $str.split(/\s+/).grep({ tokenValid($_) }).elems
}

sub solution($str) {
  say qq/Input: \$str = "$str"/;
  say qq/Output: {validTokenCount($str)}/;
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
