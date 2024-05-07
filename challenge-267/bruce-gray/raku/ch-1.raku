# Concise alternatives:
# my &task1 = *».sign.reduce(&[*]);
# my &task1 = { [*] @^ns».sign }

# No time to write comparison tests this week; this Bag-based solution also works, with no multiplication.
# sub task1 ( @ns --> Int ) {
#     my $b = @ns».sign.Bag;
#
#     return $b{0}           ??  0
#         !! $b{-1} !%% 2    ?? -1
#         !! $b{-1} || $b{1} ??  1
#         !!                     Nil;
# }

# Early return
sub task1 ( @ns --> Int ) {
    return Nil if not @ns;

    my $ret = 1;

    for @ns {
        $ret *= .sign
            or return 0;
    }
    return $ret;
}


use Test; plan +constant @tests =
    (   1, ( -1, -2, -3, -4,  3, 2, 1 ) ),
    (   0, (  1,  2,  0, -2, -1       ) ),
    (  -1, ( -1, -1,  1, -1,  2       ) ),

    ( Nil, [ ]                          ),
;
for @tests -> ( $expected, @ns ) {
    is task1(@ns), $expected;
}
