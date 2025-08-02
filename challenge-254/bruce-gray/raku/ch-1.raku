multi sub task1_Cubes ( UInt $n --> Bool ) {  $n == (   $n  ** ⅓ ).round³ }
multi sub task1_Cubes (  Int $n --> Bool ) { -$n == ( (-$n) ** ⅓ ).round³ }

multi sub task1_PO3_log (       0 --> Bool ) { False } # XXX 3 ** -Inf == 0
multi sub task1_PO3_log ( UInt $n --> Bool ) { $n == 3 ** $n.log(3).round }

sub task1_PO3_div ( UInt $n is copy --> Bool ) {
    $n div= 3 while $n and $n %% 3;

    return $n == 1;
}

use ntheory:from<Perl5> <rootint logint>;
multi sub task1_Perl_Cube (UInt $n) { return $n    == rootint( $n, 3)³ }
multi sub task1_Perl_Cube (Int  $n) { return (-$n) == rootint(-$n, 3)³ }
multi sub task1_Perl_PO3  (     $n) { return $n    ==  logint( $n, 3) R** 3 }
multi sub task1_Perl_PO3  (      0) { False }


my @tests_Cubes =
    (  27, True  ),
    (   0, True  ),
    (   6, False ),

    # Cubes could be negative; (-3)³ == -27
    (  -6, False ),
    (  -9, False ),
    ( -27, True  ),
;
my @tests_PO3 =
    (  27, True  ),
    (   0, False ), # Different than the 0 test in Cubes, since 3**n == 0 for no `n`
    (   6, False ),
;
append @tests_Cubes, map { |(($_ - 1, False), ($_, True), ($_ + 1, False)) }, map { $_ ** 3  }, flat(2..100, 2**20);
append @tests_PO3  , map { |(($_ - 1, False), ($_, True), ($_ + 1, False)) }, map {  3 ** $_ }, 2..39;

my @subs_Cubes = 
    :&task1_Cubes,
    :&task1_Perl_Cube,
;
my @subs_PO3 = 
    :&task1_PO3_log,
    :&task1_PO3_div,
    :&task1_Perl_PO3,
;
use Test;
plan ( +@subs_PO3   * +@tests_PO3   )
   + ( +@subs_Cubes * +@tests_Cubes );
for @subs_PO3 -> ( :key($sub_name), :value(&task1) ) {
    for @tests_PO3 -> ( Int $in, Bool $expected ) {
        is task1($in), $expected, "PO3   : $sub_name $in -> $expected";
    }
}
for @subs_Cubes -> ( :key($sub_name), :value(&task1) ) {
    for @tests_Cubes -> ( Int $in, Bool $expected ) {
        is task1($in), $expected, "Cubes : $sub_name $in -> $expected";
    }
}
