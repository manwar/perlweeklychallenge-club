#!/usr/bin/raku

sub MAIN(
     Str $s #= a string of upper or lower case letters
) {
     grammar Validator {
          rule TOP { <capitalized> | <all-upper> | <all-lower> }
          rule capitalized { <upper><all-lower> }
          rule all-upper { <upper>+ }
          rule all-lower { <lower>+ }
          token upper { <[A .. Z]> }
          token lower { <[a .. z]> }
     }

     say Validator.parse($s) ?? 1 !! 0;
}