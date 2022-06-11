#!/usr/bin/env perl6
#
#
#       159-2-squarefree-is-only-one-side-of-the-story.raku
#
#
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##





unit sub MAIN ( $num = 302 ) ;

sub moebius ($num) {
    my @primes = (2..$num).grep: { .is-prime && $num %% $_ };

    return 0 if @primes.grep: $num %% *² ;
    return (-1)**@primes.elems ;
}


## testing 

use Test;
plan 8;

is moebius( 5), -1, 'ex-1';
is moebius(10),  1, 'ex-2';
is moebius(20),  0, 'ex-3';

is moebius( 2), -1, 'edge-2';
is moebius( 3), -1, 'dege-3';

is moebius(46),  1, 'mid-46';
is moebius(47), -1, 'mid-47';
is moebius(48),  0, 'mid-48';

