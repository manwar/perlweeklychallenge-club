#!/usr/bin/env perl
use v5.44;

sub parseComplex($c) {
  my $integer = qr/[+-]? \d+ | \( \s* [+-]? \d+ \s* \)/x;
  $c =~ / ($integer) \s* ([+-]) \s* ($integer) \s* i/x;
  my ($real, $op, $imag) = ($1, $2, $3);
  $real =~ s/[()]//g; # strip parens
  $imag =~ s/[()]//g;
  $real = int($real);
  $imag = $op eq '-' ? -1 * int($imag) : int($imag);
  ($real, $imag)
}

sub complexMult($num1, $num2) {
  my ($a, $b) = parseComplex($num1);
  my ($c, $d) = parseComplex($num2);
  my $e = ($a * $c) - ($b * $d);
  my $f = ($a * $d) + ($b * $c);
  $f = $f < 0 ? "(@{[$f]})" : $f;
  "@{[$e]}+@{[$f]}i"
}

sub solution($num1, $num2) {
  say qq/Input: \$num1 = "$num1", \$num2 = "$num2"/;
  say 'Output: "' . complexMult($num1, $num2) . '"';
}

say "Example 1:";
solution("1+1i", "1+1i");

say "\nExample 2:";
solution("1+(-1)i", "1+(-1)i");

say "\nExample 3:";
solution("0+3i", "0+4i");

say "\nExample 4:";
solution("3+4i", "3+(-4)i");

say "\nExample 5:";
solution("50+(-20)i", "-10+30i");

say "\nExample 6:";
solution("-2+5i", "5-5i");
