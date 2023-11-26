#!/usr/bin/env raku
use v6;

sub firstOfSecond { $^a ~ substr($^b, 0, 1) };

sub makeAcronym(@str) {
  my $acronym = [[&firstOfSecond]] ('', |@str);
  return $acronym.lc;
}

sub solution($chk, @str) {
  say 'Input: @str = ("' ~ @str.join('", "') ~ '")';
  say '       $chk = ("' ~ $chk ~ '")';
  my ($acronym) = makeAcronym(@str);
  say 'Output: ' ~ ($acronym eq $chk ?? 'true' !! 'false');
}

say "Example 1:";
solution("ppp", ["Perl", "Python", "Pascal"]);

say "\nExample 2:";
solution("rp", ["Perl", "Raku"]);

say "\nExample 3:";
solution("oac", ["Oracle", "Awk", "C"]);