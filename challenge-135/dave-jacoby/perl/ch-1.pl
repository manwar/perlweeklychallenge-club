#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say state postderef signatures };
no warnings qw{ experimental };

my @examples = qw{
    1234567
    -123
    1
    10
};

for my $i (@examples) {
    my $o = middle_3($i);
    say <<"END";
    Input: \$n = $i
    Output: $o
END
}

sub middle_3 ( $n ) {
    $n =~ s/\D//gmx;
    my $s = length $n;
    return 'even number of digits' if ( $s % 2 ) == 0;
    return 'too short'             if $s < 3;
    while ( length $n > 3 ) {
        substr( $n, 0,  1 ) = '';
        substr( $n, -1, 1 ) = '';
    }
    return $n;
}
