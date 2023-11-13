#!/usr/bin/env perl
use v5.38;

use List::Util qw( reduce );

sub makeAcronym {
  my $str = shift;
  my $acronym = reduce { $a . substr($b, 0, 1) } '', @$str;
  return lc($acronym);
}

sub solution($chk, $str) {
  say 'Input: @str = ("' . join('", "', @$str). '")';
  say '       $chk = ("' . $chk . '")';
  my ($acronym) = makeAcronym($str);
  say 'Output: ' . ($acronym eq $chk ? 'true' : 'false');
}

say "Example 1:";
solution("ppp", ["Perl", "Python", "Pascal"]);

say "\nExample 2:";
solution("rp", ["Perl", "Raku"]);

say "\nExample 3:";

solution("oac", ["Oracle", "Awk", "C"]);