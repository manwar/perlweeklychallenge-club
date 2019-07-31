#!/usr/bin/env perl6

sub all-substrings(Str $in) {
  gather for (^($in.chars - 1)).hyper -> $i {
    for (1..^$in.chars).hyper -> $j {
      take $in.substr($i..$j) if $i <= $j;
    }
  }
}

sub MAIN(*@strings) {
  my @subs = all-substrings(@strings[0]).sort(- *.chars).unique;

  for @strings[1..*].hyper -> $B {
    @subs .= grep: -> $A {
      $A.chars <= $B.chars && (0..($B.chars - $A.chars)).grep: -> $i {
	$B.substr-eq($A, $i)
      }
    }
  };

  say @subs.first;
}
