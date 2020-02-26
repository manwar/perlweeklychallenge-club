#!/usr/bin/env perl6

# ch-1.p6 - Attractive numbers
#
# Ryan Thompson <rjt@cpan.org>

sub MAIN( Int :$max = 50 ) {
    .say for (1..$max).grep: *.divisors.is-prime;
}

# WARNING: `augment' has global scope
# https://docs.perl6.org/syntax/augment
# I'm using it here to demonstrate a unique language feature.

use MONKEY-TYPING;

augment class Int {

    #| Return an Array of prime divisors (with multiplicity)
    method divisors returns Array {
        my @div;
        my $n = self;
        for (2..self.sqrt).grep: *.is-prime -> $div {
            while $n % $div == 0 {
                $n /= $div;
                @div.push: $div;
            }
        }
        @div;
    }

}
