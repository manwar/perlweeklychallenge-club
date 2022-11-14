sub task1 ( Str $_ --> Bool ) { so $_ eq (.lc | .uc | .tclc) }

my @tests =
    ( 'Perl'   , 1 ),
    ( 'TPF'    , 1 ),
    ( 'PyThon' , 0 ),
    ( 'raku'   , 1 ),
;
use Test;
plan +@tests;
for @tests -> ( $input, $expected ) {
    is-deeply +task1($input), $expected, "task1('$input')";
}
