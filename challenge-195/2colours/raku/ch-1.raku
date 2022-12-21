#!/usr/bin/env raku

subset PosInt of Int where * > 0;

multi count-special-until(PosInt $max) {
  samewith .chars, .comb, '0' .. '9', :first-digit given $max 
}

multi count-special-until(1, @max, Set() $not-used, Bool :$first-digit = False --> PosInt) {
  $not-used.keys.grep({ not $_ after @max.head || $first-digit && $_ eq '0' }).elems
}

multi count-special-until(PosInt $digits, @max, Set() $not-used, Bool :$first-digit = False --> Int) {
  my $classified = $not-used.keys.classify(* cmp @max[0]);
  my Set() $less = $classified{Less} // Empty;
  $less (-)= '0' if $first-digit;
  my Set() $same = $classified{Same} // Empty;
  my $result = 0;
  $result += samewith($digits - 1, [ ** ], $not-used, :first-digit) if $first-digit;
  $result += $less * samewith($digits - 1, [ ** ], $not-used (-) $less.keys[0]) if $less > 0; # doesn't matter for the calculation which digit is marked as used
  $result += samewith($digits - 1, @max.skip, $not-used (-) $same.keys[0]) if $same;
  $result
}

sub MAIN(
  PosInt $n #= upper limit for counting special numbers
) {
  $n.&count-special-until.say;
}
