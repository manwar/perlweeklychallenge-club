#!/usr/bin/env perl6

# ch-1.p6 - Cryptic message
#
# Ryan Thompson <rjt@cpan.org>

#| Decode extremely unreliable transmission
sub decode( @strings ) {
    my @col-count;
    for @strings».split: ' ' -> $row {
        @col-count[.key]{.value}++ for |$row.pairs;
    }
    @col-count».sort(-*.value)».first».key.join;
}


#
# Testing
#

use Test;

plan(3);
is decode(('H x l 4 !',
           'c e - l o',
           'z e 6 l g',
           'H W l v R',
           'q 9 m # o')), 'Hello';

is decode(('P + 2 l ! a t o',
           '1 e 8 0 R $ 4 u',
           '5 - r ] + a > /',
           'P x w l b 3 k \\',
           '2 e 3 5 R 8 y u',
           '< ! r ^ ( ) k 0')), 'PerlRaku';

is decode(('H x l 4 !',
           'c e - l o',
           'z e 6 l',    # Missing character
           'H W l v R',
           'q 9 m # o')), 'Hello';

done-testing;
