#! /usr/bin/env perl6

# https://docs.perl6.org/language/nativecall

use NativeCall;

sub toupper(uint8) returns uint8 is native('c', v6) { * }

sub to-upper ($string)
{
  return $string.comb.map({ toupper($_.ord).chr }).join;
}

sub MAIN ($string)
{
  say "Before: $string";

  my $new = to-upper($string);

  say "After:  $new";
}

