#!/usr/bin/env perl6

use v6.d;

grammar Roman {
  regex TOP { [[ $<prefix> = 'C' ]? $<M> = 'M']* [ $<suffix> = <.D> ] }

  regex D   { [[ $<prefix> = 'C' ]? $<D> = 'D']* [ $<suffix> = <.C> ]}

  regex C   { [[ $<prefix> = 'X' ]? $<C> = 'C']* [ $<suffix> = <.L> ] }

  regex L   { [[ $<prefix> = 'X' ]? $<L> = 'L']* [ $<suffix> = <.X> ] }

  regex X   { [[ $<prefix> = 'I' ]? $<X> = 'X']* [ $<suffix> = <.V> ] }

  regex V   { [[ $<prefix> = 'I' ]? $<V> = 'V']* [ $<suffix> = <.I> ] }

  regex I   { [ $<I> = 'I' ]* }
}

class RomanCalc {
  method TOP($/) {
    make $<M>.elems * 1000 + $<suffix>.made - 100 * $<prefix>.elems;
  }
  method D($/) {
    make $<D>.elems * 500  + $<suffix>.made - 100 * $<prefix>.elems;
  }
  method C($/) {
    make $<C>.elems * 100  + $<suffix>.made - 10  * $<prefix>.elems;
  }
  method L($/) {
    make $<L>.elems * 50   + $<suffix>.made - 10  * $<prefix>.elems;
  }
  method X($/) {
    make $<X>.elems * 10   + $<suffix>.made - $<prefix>.elems;
  }
  method V($/) {
    make $<V>.elems * 5    + $<suffix>.made - $<prefix>.elems;
  }
  method I($/) {
    make $<I>.elems || 0;
  }
}

multi convert-roman(Int $input){
  my Int $num = $input;
  my $roman = '';

  my @nmap = (1000 => 'M', 900 => 'CM', 500 => 'D', 400 => 'CD',
              100 => 'C', 90 => 'XC', 50 => 'L', 40 => 'XL',
              10 => 'X', 9 => 'IX', 5 => 'V', 4 => 'IV', 1 => 'I');

  for @nmap {
    if $num >= .key {
      $roman ~= .value x ($num div .key);
      $num %= .key;
    }
  }

  $roman;
}

multi convert-roman(Str $input) {
  my $parsed = Roman.parse($input, actions => RomanCalc);

  $parsed.made;
}

for @*ARGS -> $input {
  say $input ~ " → " ~ convert-roman(+$input || $input)
}
