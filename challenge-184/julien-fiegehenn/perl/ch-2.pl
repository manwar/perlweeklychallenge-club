#!perl
use strict;
use warnings;

sub array_split {
    my @strings = @_;
    my ( @numbers, @letters );
    foreach my $string (@strings) {
        push @numbers, [];
        push @letters, [];
        foreach my $char ( split /\s/, $string ) {
            push @{ ( $char =~ m/\d/ ? @numbers : @letters )[-1] }, $char;
        }
        pop @numbers unless scalar @{ $numbers[-1] };
        pop @letters unless scalar @{ $letters[-1] };
    }
    return \@numbers, \@letters;
}

use Test::More;
use Test::Deep;

cmp_deeply(
    [ array_split( 'a 1 2 b 0', '3 c 4 d' ) ],
    [ [ [ 1, 2, 0 ], [ 3, 4 ] ], [ [ 'a', 'b' ], [ 'c', 'd' ] ] ],
    'first example'
);
cmp_deeply(
    [ array_split( '1 2', 'p q r', 's 3', '4 5 t' ) ],
    [ [ [ 1, 2 ], [3], [ 4, 5 ] ], [ [ 'p', 'q', 'r' ], ['s'], ['t'] ] ],
    'second example'
);

done_testing;