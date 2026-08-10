#!/usr/bin/env perl
use v5.44;

sub primitives($str, $prim, $count, $primitives) {
  my $char = substr $str,0,1; # first char
  $str = substr $str, 1;      # remaining string
  $prim .= $char;             # append char to current primative
  if ($char eq ')') {
    $count--;                   # decrease paren count
    if ($count == 0) {          # we found the end of a primative
      push @$primitives, $prim; # add to primative list
      $prim = "";               # clear current primative
    }
  }
  else {
     $count++; # increase paren count
  }
  return if $str eq ""; # we've finished the string

  # recursively call to process rest of string
  primitives($str, $prim, $count, $primitives);
}

sub outermostParentheses($str, $primitives=[]) {
  primitives($str, "", 0, $primitives);
  join '', map { substr $_, 1, -1 } @$primitives;
}

sub solution($str) {
  say 'Input: $str = "' . $str . '"';
  my @primitives;
  my $output = outermostParentheses($str, \@primitives);
  say 'Output: "' . $output . '"';
  say "\nPrimitive Decomposition: " . join(' + ', map { qq/"$_"/ } @primitives);
}

say "Example 1:";
solution("()()()");

say "\nExample 2:";
solution("(((())))");

say "\nExample 3:";
solution("(()())(())");

say "\nExample 4:";
solution("()((()))()");

say "\nExample 5:";
solution("(()(()))(()())");
