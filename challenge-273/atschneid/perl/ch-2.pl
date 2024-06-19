use strict;
use warnings;

use v5.38;

my @inputs = ( 'aabb', 'abab', 'aaa', 'bbb', 'aaaffeoioijlkfjoihslkjhfb' );

for my $input (@inputs) {
    say "$input :: " . (check_a_b_string( $input ) ? 'true' : 'false');
}

sub check_a_b_string( $string ) {
    # find the first 'b' index
    # if there's none (ie returns -1) then false
    return 0 if 0 > ( my $first_b_idx = index $string, 'b' );

    # if there are any 'a's after the first 'b' then false
    return 0 if ( substr $string, $first_b_idx ) =~ tr/a//;

    # otherwise true!
    return 1;
}
