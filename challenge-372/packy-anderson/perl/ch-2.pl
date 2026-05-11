#!/usr/bin/env perl
use v5.40;

use List::AllUtils  qw( max );
use List::MoreUtils qw( frequency );

sub largest($str) {
  my $max = 0;
  my @explain;
  my %chars = frequency split //, $str;
  foreach my ($c, $f) ( %chars ) {
    next unless $f > 1; # filter out single chars
    $str =~ /$c (.*) $c/x;
    $max = max($max, length($1));
    push @explain,
      qq[For character "$c", we have substring "$1".];
  }
  $max . "\n\n" . join("\n", @explain)
}

sub solution($str) {
  say qq[Input: \$str = "$str"];
  say qq|Output: @{[largest($str)]}|;
}

say "Example 1:";
solution("aaaaa");

say "\nExample 2:";
solution("abcdeba");

say "\nExample 3:";
solution("abbc");

say "\nExample 4:";
solution("abcaacbc");

say "\nExample 5:";
solution("laptop");