# Notice the use of the plain dot as a string, instead of the escaped dot in a regex that Perl's `s/\./[.]/g` would need.
sub task1 ( Str $fanged --> Str ) {
    return $fanged.subst: :g, '.', '[.]';
}

# constant &task1 = *.subst: :g, '.', '[.]'; # Same thing, but shorter.

# .trans would also work, possibly more efficiently than .subst,
# but with harder-to-read syntax due to replacing single-chars with multi-chars, like:
#       .trans: ['.'] => ['[.]'];



use Test; plan +constant @tests =
    ( '1.1.1.1'     , '1[.]1[.]1[.]1'     ),
    ( '255.101.1.0' , '255[.]101[.]1[.]0' ),
;
for @tests -> ($in, $expected) {
    is task1($in), $expected, "$in";
}
