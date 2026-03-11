#!/usr/bin/env raku
use v6;

my $jz_re = rx/(\d\d)(\#)/;
my $ai_re = rx/(\d)/;

sub decrypt($str is copy) {
  $str.subst($jz_re, { chr( $0 + 96 ) }, :g)
      .subst($ai_re, { chr( $0 + 96 ) }, :g);
}

sub solution($str) {
  say qq/Input: \$str = "$str"/;
  say qq/Output: "{decrypt($str)}"/;
}

say "Example 1:";
solution("10#11#12");

say "\nExample 2:";
solution("1326#");

say "\nExample 3:";
solution("25#24#123");

say "\nExample 4:";
solution("20#5");

say "\nExample 5:";
solution("1910#26#");
