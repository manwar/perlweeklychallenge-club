#!/usr/bin/env perl
use v5.40;

my $jz_re = qr/(\d\d)(\#)/;
my $ai_re = qr/(\d)/;

sub decrypt($str) {
  $str =~ s/$jz_re/chr( $1 + 96 )/eg;
  $str =~ s/$ai_re/chr( $1 + 96 )/eg;
  $str;
}

sub solution($str) {
  say qq/Input: $str = "$str"/;
  say qq/Output: "@{[decrypt($str)]}"/;
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
