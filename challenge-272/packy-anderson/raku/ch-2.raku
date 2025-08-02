#!/usr/bin/env raku
use v6;

sub score($str) {
  my @chars = $str.comb;
  my @vals  = @chars.map: { .ord };
  my @explain = ("ASCII values of characters:");
  for @chars Z @vals -> ($c, $v) {
    @explain.push: "$c = $v";
  }
  my @line1;
  my @line2;

  my $last = @vals.shift;
  while (my $next = @vals.shift) {
    @line1.push: "| $last - $next |";
    @line2.push: abs($last - $next);
    $last = $next;
  }
  @explain.push: "Score => " ~ @line1.join(" + ");
  @explain.push: "      => " ~ @line2.join(" + ");
  my $score = [+] @line2;
  @explain.push: "      => " ~ $score;

  return $score, @explain.join("\n");
}

sub solution($str) {
  say 'Input: $str = "' ~ $str ~ '"';
  my ($score, $explain) = score($str);
  say "Output: $score\n\n$explain";
}

say "Example 1:";
solution("hello");

say "\nExample 2:";
solution("perl");

say "\nExample 3:";
solution("raku");
