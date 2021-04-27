#!/usr/bin/env raku

# ch-1.raku - Phone number validation
#
# Ryan Thompson <rjt@cpan.org>

# Phone number, with country code, optional whitespace,
# inner whitespace, and local number
grammar Phone-Number {
  token TOP   { <ows> <cc> <iws> <local> <ows> }
  token cc    { \+ \d\d | \( \d\d \) | \d ** 4 }
  token ows   { \s*      }
  token iws   { \s+      }
  token local { \d ** 10 }
}

.say for lines.grep: { Phone-Number.parse($_) }
