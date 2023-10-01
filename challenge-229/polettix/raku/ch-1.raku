#!/usr/bin/env raku
use v6;
sub MAIN (*@bills) { put exact-change(@bills) ?? 'true' !! 'false' }

sub exact-change (@bills) {
   my %bills-of = <5 0 10 0 20 0>;
   for @bills -> $bill {
      if $bill == 5 { %bills-of<5>++ }
      elsif $bill == 10 {
         return False unless %bills-of<5>-- > 0;
         %bills-of<10>++;
      }
      else { # $bill == 20
         return False unless %bills-of<5>-- > 0;
         if %bills-of<10> >= 1 {
            %bills-of<10>--;
         }
         elsif %bills-of<5> >= 2 {
            %bills-of<5> -= 2;
         }
         else {
            return False;
         }
      }
   }
   return True;
}
