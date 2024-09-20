#!/usr/bin/env perl
use v5.40;
use utf8;
binmode STDOUT, ':utf8';

my $sign = qr/ [+\-] /x;

my $digits = qr/ \d+ /x;

my $integerNumber = qr/ $sign? $digits /x;

my $decimalNumber = qr/
  $sign? (?: $digits\. | $digits\.$digits | \.$digits)
/x;

my $exponent = qr/(?: [eE] $integerNumber )/x;

my $TOP = qr/
  ^ (?: $integerNumber$exponent? | $decimalNumber$exponent? ) $
/x;

sub solution($str) {
  say qq{Input: \$str = "$str"};
  say 'Output: ' . ($str =~ /$TOP/ ? 'True' : 'False');
}

say "Example 1:";
solution("1");

say "\nExample 2:";
solution("a");

say "\nExample 3:";
solution(".");

say "\nExample 4:";
solution("1.2e4.2");

say "\nExample 5:";
solution("-1.");

say "\nExample 6:";
solution("+1E-8");

say "\nExample 7:";
solution(".44");

say "\nExample 8:";
solution("-३.१")