#!/usr/bin/env raku
use v6;

sub primitives($str is copy,       $prim is copy = "",
               $count is copy = 0, @primitives = []) {
  my $char = $str.substr(0,1); # first char
  $str = $str.substr(1);      # remaining string
  $prim ~= $char;             # append char to current primative

  if ($char eq ')') {
    $count--;                  # decrease paren count
    if ($count == 0) {         # we found the end of a primative
      @primitives.push($prim); # add to primative list
      $prim = "";              # clear current primative
    }
  }
  else {
     $count++; # increase paren count
  }
  return @primitives if $str eq ""; # we've finished the string

  # recursively call to process rest of string
  return primitives($str, $prim, $count, @primitives);
}

sub outermostParentheses($str, @primitives) {
  @primitives = primitives($str);
  @primitives.map({ $_.substr(1, *-1)}).join;
}

sub solution($str) {
  say 'Input: $str = "' ~ $str ~ '"';
  my @primitives;
  my $output = outermostParentheses($str, @primitives);
  say 'Output: "' ~ $output ~ '"';
  say "\nPrimitive Decomposition: " ~ @primitives.map({ qq/"$_"/ }).join(' + ');
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
