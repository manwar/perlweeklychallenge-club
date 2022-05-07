#!/usr/bin/env raku

# skeleton.raku - TODO
#
# 2021 Ryan Thompson <rjt@cpan.org>

sub MAIN(*@n where +* #={ List of positive integers } ) {
    sum_rec(|@n).say;
}

sub sum_rec(*@n) {
    return @n[0] if @n.elems == 1;
    sum_rec((1..@n.elems-1).map({ [+] @n[1..$_] }));
}
