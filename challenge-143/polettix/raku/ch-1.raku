#!/usr/bin/env raku
use v6;

grammar Calc {
    rule TOP        { ^ <expression> $ }
    rule expression { <term>+ %% $<op>=(['+'|'-']) | <group> }
    rule term       { <factor>+  %% $<op>=(['*']) }
    rule factor     { <value> | <group> }
    rule group      { '(' <expression> ')' }
    token value     { 0 | <[ 1..9 ]> \d* }
}

class Actions {
   method TOP ($/) { $/.make: $<expression>.made }
   method expression ($/) {
      if $<group> { $/.make: $<group>.made }
      else        { $/.make: self!calc($<term>, $<op>) }
   }
   method term ($/) { $/.make: self!calc($<factor>, $<op>) }
   method factor ($/) {
      if $<group> { $/.make: $<group>.made }
      else        { $/.make: $<value>.made }
   }
   method group ($/) { $/.make: $<expression>.made }
   method value ($/) { $/.make: +$/ }

   method !calc ($operands, $operators) {
      my ($retval, @vals) = $operands».made;
      my @ops = $operators.map: ~*;
      for @ops Z @vals -> ($_, $val) {
         when '*' { $retval *= $val }
         when '+' { $retval += $val }
         when '-' { $retval -= $val }
      }
      return $retval;
   }
}

sub MAIN ($expression) {
   my $calc = Calc.parse($expression, actions => Actions)
      or die 'cannot parse input expression';
   say $calc.made;
}
