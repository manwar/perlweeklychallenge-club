#!env raku
#
# Perl Weekly Challenge 58
#
# Task 1
#
# Compare two given version number strings v1 and v2 such that:
#
#     If v1 > v2 return 1
#     If v1 < v2 return -1
#     Otherwise, return 0
#
#     The version numbers are non-empty strings containing only digits,
#     and the dot (“.”) and underscore (“_”) characters.
#     (“_” denotes an alpha/development version, and has a lower precedence than a dot, “.”). Here are some examples:
#
#     v1   v2    Result
#     ------ ------ ------
#     0.1 < 1.1     -1
#     2.0 > 1.2      1
#     1.2 < 1.2_5   -1
#     1.2.1 > 1.2_1    1
#     1.2.1 = 1.2.1    0
#    Version numbers may also contain leading zeros. You may handle these how you wish, as long as it’s consistent.


sub MAIN() {
    my Str @test = '0.1', '1.1'
        , '2.0', '1.2'
        , '1.2', '1.2_5'
        , '1.2.1', '1.2_1'
        , '1.2.1', '1.2.1';


    for @test -> $v1, $v2 {
        my $v1n = $v1.Str.subst( '.', 9, :g ).subst( '_', '0', :g );
        my $v2n = $v2.Str.subst( '.', 9, :g ).subst( '_', '0', :g );
        say "Comparing $v1 vs $v2 -> " ~ do  given $v1n <=> $v2n {
            when More { 1 }
            when Less { -1 }
            when Same { 0 }
        };

    }
}
