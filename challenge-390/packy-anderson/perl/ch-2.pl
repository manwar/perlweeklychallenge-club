#!/usr/bin/env perl
use v5.44;

sub orderCharacters($str, $k) {
  my %seen  = ($str => 1);
  my @stack = ($str);
  while ($str = shift @stack) {
    for my $i (0 .. $k-1) {
      my $char = substr($str,$i,1);
      my $new  = substr($str,0,$i) . substr($str,$i+1) . $char;
      next if exists $seen{$new};
      $seen{$new}++;
      push @stack, $new;
    }
  }
  return (sort keys %seen)[0];
}

sub solution($str, $k) {
  say qq/Input: \$str = "$str", \$k = $k/;
  say qq/Output: "@{[orderCharacters($str, $k)]}"/;
}

say "Example 1:";
solution("dbca", 1);

say "\nExample 2:";
solution("geeks", 2);

say "\nExample 3:";
solution("cbaed", 3);

say "\nExample 4:";
solution("fedcba", 4);

say "\nExample 5:";
solution("perl", 1);

say "\nExample 6:";
solution("oloolooo", 1);

say "\nExample 7:";
solution("oloooolo", 1);