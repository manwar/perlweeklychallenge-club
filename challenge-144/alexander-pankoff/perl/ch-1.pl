#!/usr/bin/env perl
use strict;
use warnings;
use feature qw'say signatures';
no warnings qw'experimental::signatures';

use File::Spec;
use FindBin;
use List::Util qw(all);

package Challenge143Task02 {
    require File::Spec->catfile( $FindBin::RealBin,
        qw'.. .. .. challenge-143 alexander-pankoff perl ch-2.pl' );
}

run() unless caller();

sub run() {
    say join( " ", grep { is_semi_prime($_) } 1 .. 100 );
}

sub is_semi_prime($n) {
    my @pairs = Challenge143Task02::find_divisors_pairs($n);
    return @pairs == 2 && all { is_prime($_) } @{ $pairs[1] };
}

sub is_prime($n) {
    return $n > 1
      && Challenge143Task02::find_divisors_pairs($n) == 1;
}

