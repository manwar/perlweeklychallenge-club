#!/usr/bin/env raku
use v6;

sub replaceAllQuestion($str is copy) {
  # return the unmodified string if there are no ? characters
  return $str unless $str ~~ /$<before> = . \?+ $<after> = ./;

  # since we matched something, let's replace the first ? with a
  # character that won't produce a consecutive repeating character
  my $replace = ('a' .. 'z')
              .grep({$_ ne $<before> && $_ ne $<after> })
              .pick(); # let's not always use the first character

  # we're EXPLICITLY only replacing the first ?
  $str ~~ s/\?/$replace/;

  # recursively call this function to replace any remaining ?s
  return replaceAllQuestion($str);
}

sub solution($str) {
  say "Input: \$str = \"$str\"";
  say "Output: \"{replaceAllQuestion($str)}\"";
}

say "Example 1:";
solution("a?z");

say "\nExample 2:";
solution("pe?k");

say "\nExample 3:";
solution("gra?te");

say "\nExample 4:";
solution("so?c?r");

say "\nExample 5:";
solution("mi??i??i??i");

say "\nExample 6:";
solution("i??????????????????n");