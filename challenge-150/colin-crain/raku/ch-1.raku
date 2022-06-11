#!/usr/bin/env perl6
#
#
#       150-1-the-51st-piece-of-string.raku
#
#
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN ( $zero = 'abcdefg', $one = 'tuvwxyz' ) ;

my @F = $zero, $one;


while @F[*-1].chars < 51 {
    @F.push: @F[*-2] ~ @F[*-1];
}


say qq:to/END/;
    the words generated, with a helpful guide:

    {@F.join: "\n"}

    {("0123456789" xx 6).join}
    {(' ', |(1..5)).join: '         '}

    start string 0: $zero
    start string 1: $one

    the 51st character in the first term long enough to have one is "{@F[*-1].substr(50, 1)}"
    END
