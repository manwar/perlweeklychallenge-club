#!/usr/bin/env raku
use v6;
sub MAIN (Str:D $input = '978-0-306-40615-7') {
   put "ISBN-13 check digit for '$input' is {isbn_13($input)}.";
}

sub isbn_13 ($input) {
   $input.comb(/\d/)[0..11]    # focus on first 12 digits
      .map({-$^a - 3 * $^b})   # apply equivalent weights
      .sum % 10;               # sum and take remainder
}
