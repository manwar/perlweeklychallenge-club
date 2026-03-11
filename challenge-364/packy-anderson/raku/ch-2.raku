#!/usr/bin/env raku
use v6;

my $al_re = rx/\(al\)/;
my $o_re  = rx/\(\)/;

sub parser($str is copy) {
  $str.subst($al_re, "al", :g)
      .subst($o_re,  "o",  :g);
}

sub solution($str) {
  say qq/Input: \$str = "$str"/;
  say qq/Output: "{parser($str)}"/;
}

say "Example 1:";
solution("G()(al)");

say "\nExample 2:";
solution("G()()()()(al)");

say "\nExample 3:";
solution("(al)G(al)()()");

say "\nExample 4:";
solution("()G()G");

say "\nExample 5:";
solution("(al)(al)G()()");
