#!/usr/bin/env perl
use v5.40;

use List::AllUtils qw( shuffle );

sub replaceAllQuestion($str) {
  # return the unmodified string if there are no ? characters
  return $str unless $str =~ /(?<before> .) \?+ (?<after> .)/x;

  # since we matched something, let's replace the first ? with a
  # character that won't produce a consecutive repeating character
  my $replace = (
    shuffle ( # let's not always use the first character
      grep {$_ ne $+{before} && $_ ne $+{after} } ('a' .. 'z')
    )
  )[0]; # but pull the first character off the shuffled list

  # we're EXPLICITLY only replacing the first ?
  $str =~ s/\?/$replace/;

  # recursively call this function to replace any remaining ?s
  return replaceAllQuestion($str);
}

sub solution($str) {
  say "Input: \$str = \"$str\"";
  say "Output: \"@{[replaceAllQuestion($str)]}\"";
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