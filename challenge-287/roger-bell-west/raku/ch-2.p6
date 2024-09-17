#! /usr/bin/raku

use Test;

plan 7;

is(validnumber('1'), True, 'example 1');
is(validnumber('a'), False, 'example 2');
is(validnumber('.'), False, 'example 3');
is(validnumber('1.2e4.2'), False, 'example 4');
is(validnumber('-1.'), True, 'example 5');
is(validnumber('+1E-8'), True, 'example 6');
is(validnumber('.44'), True, 'example 7');

sub validnumber($a) {
  my $integer = '<[-+]>?<[0..9]>+';
  my $float = '<[-+]>?(<[0..9]>+\.<[0..9]>*|<[0..9]>*\.<[0..9]>+)';
  my $exponential =
    '(' ~ $integer ~ '|' ~ $float ~ ')<[Ee]>' ~ $integer;
  my $number =
      '^(' ~ $integer ~ '|' ~ $float ~ '|' ~ $exponential ~ ')$';
  if $a ~~ /<$number>/ {
      return True;
  } else {
      return False;
      }
}
