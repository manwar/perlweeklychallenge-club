#!/usr/bin/env perl6
use v6;

#| Expand braces (nesting NYI)
sub MAIN (
  *@phrase where * > 0,
  --> Nil
) {
  given @phrase.join: ' ' -> $str {
    given $str.match: /^ ( .*? ) '{' ( .* ) '}' ( .*? ) $/ {
      when .[1].so {
        for .[1].split: ',' -> $split {
          "$_[0]$split$_[2]".say;
        }
      }
      default { $str.say }
    }
  }
}
