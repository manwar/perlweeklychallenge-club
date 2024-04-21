#!/usr/bin/env perl
use v5.38;

sub letterCounts($str) {
  my %counts;
  map { $counts{$_}++ } grep { /[a-z]/ } split //, lc($str);
  return %counts;
}

sub completingWord($str, @str) {
  my %target = letterCounts($str);
  my $shortest;
  CANDIDATE: foreach my $s ( @str ) {
    my %candidate = letterCounts($s);
    foreach my $c ( keys %target ) {
      my $i = $target{$c};
      next CANDIDATE # skip this candidate
        unless exists $candidate{$c} # this letter exists
            && $candidate{$c} >= $i; # at least as many times
    }
    if (! defined($shortest) || length($s) < length($shortest)) {
      $shortest = $s;
    }
  }
  return $shortest // q{};
}

sub solution($str, @str) {
  say qq{Input: \$str = '$str'};
  say  q{       @str = ('} . join(q{', '}, @str) . q{')};
  my $output = completingWord($str, @str);
  say qq{Output: '$output'};
}

say "Example 1:";
solution('aBc 11c', 'accbbb', 'abc', 'abbc');

say "\nExample 2:";
solution('Da2 abc', 'abcm', 'baacd', 'abaadc');

say "\nExample 3:";
solution('JB 007', 'jj', 'bb', 'bjb');