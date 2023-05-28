use strict;
use warnings;
use feature 'say';

sub string_chain {
    my %first;
    my %last;
    for (@_) {
        $first{ substr $_, 0, 1 }++;
        $last{ substr $_, -1, 1 }++;
    }
    for my $first ( keys %first ) {
        return 0 unless $first{$first} == $last{$first};
    }
    return 1;
}

# Test
say string_chain( 'abc', 'dea', 'cd' );    # Output: 1
