#!/usr/bin/env perl
use v5.40;

my $al_re = qr/\(al\)/;
my $o_re  = qr/\(\)/;

sub parser($str) {
  $str =~ s/$al_re/al/g;
  $str =~ s/$o_re/o/g;
  $str;
}

sub solution($str) {
  say qq/Input: \$str = "$str"/;
  say qq/Output: "@{[parser($str)]}"/;
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

