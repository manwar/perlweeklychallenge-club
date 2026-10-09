#!/usr/bin/env perl
use v5.44;

sub isAlternating($s) {
  $s =~ /^(?: [a-z]?(?:[A-Z][a-z])+ | [A-Z]?(?:[a-z][A-Z])+ )$/x;
}

sub noalt($s, $i) {
  if ($s =~ /([A-Z]{$i} [a-z]{$i} | [a-z]{$i} [A-Z]{$i})/x) {
    # emulate raku match object
    { match => $1, from => $-[0], chars => length($1) }
  }
}

sub alternateCase($str) {
  return 0 if isAlternating($str);
  my @swaps;
  do {
    my $i = int(length($str) / 2);
    for my $j (reverse 1 .. $i) {
      next unless my $m = noalt($str, $j);
      my $start = $m->{from} + (int($m->{chars} / 2) - 1);
      my $flip = reverse substr($str, $start, 2);
      substr($str, $start, 2) = $flip;
      push @swaps, $str;
      last;
    }
  } until isAlternating($str);
  return (scalar(@swaps), @swaps);
}

sub solution($str) {
  say qq/Input: \$str = "$str"/;
  my ($count, @swaps) = alternateCase($str);
  say 'Output: ' . $count;
  if (@swaps) {
    say "";
    for my $c (0..$#swaps) {
      say qq/Swap @{[$c+1]}: "@{[$swaps[$c]]}"/;
    }
  }
}

say "Example 1:";
solution("aAbB");

say "\nExample 2:";
solution("AAbb");

say "\nExample 3:";
solution("AAAbbb");

say "\nExample 4:";
solution("aABb");

say "\nExample 5:";
solution("bBBAaa");
