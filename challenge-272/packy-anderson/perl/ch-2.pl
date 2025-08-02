#!/usr/bin/env perl
use v5.38;

use List::Util qw( sum zip );

sub score($str) {
  my @chars = split //, $str;
  my @vals  = map { ord($_) } @chars;
  my @explain = ("ASCII values of characters:");
  foreach my $z ( zip \@chars, \@vals ) {
    my ($c, $v) = @$z;
    push @explain, "$c = $v";
  }
  my @line1;
  my @line2;

  my $last = shift @vals;
  while (my $next = shift @vals) {
    push @line1, "| $last - $next |";
    push @line2, abs($last - $next);
    $last = $next;
  }
  push @explain, "Score => " . join(" + ", @line1);
  push @explain, "      => " . join(" + ", @line2);
  my $score = sum @line2;
  push @explain, "      => " . $score;

  return $score, join("\n", @explain);
}

sub solution($str) {
  say 'Input: $str = "' . $str . '"';
  my ($score, $explain) = score($str);
  say "Output: $score\n\n$explain";
}

say "Example 1:";
solution("hello");

say "\nExample 2:";
solution("perl");

say "\nExample 3:";
solution("raku");
