
=head1

Week 187:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-187/#TASK2

Task #2: Magical Triplets

    You are given a list of positive numbers, @n, having at least 3 numbers.
    Write a script to find the triplets (a, b, c) from the given list that
    satisfies the following rules
    i.e. 'a + b > c', 'b + c > a', 'a + c > b' and 'a + b + c' is maximum.
    In case, you end up with more than one triplets having the maximum then
    pick the triplet where 'a >= b >= c'.

=cut

use strict;
use warnings;
use feature 'say';

use List::Util qw/sum/;
use Test::More;
use Data::Dumper;

$Data::Dumper::Indent = 0;

my @cases = (
    [ [ 1, 2, 3, 2 ], [ 3, 2, 2 ] ],
    [ [ 1, 3, 2 ],    [] ],
    [ [ 1, 1, 2, 3 ], [] ],
    [ [ 2, 4, 3 ],    [ 4, 3, 2 ] ],
);
for my $case (@cases) {
    is_deeply( magicalTriplets( @{ $case->[0] } ), $case->[1], Dumper( $case->[0] ) );
}

done_testing( scalar @cases );

sub magicalTriplets {
    my @numbers = @_;
    my @triplet = ();
    for ( my $i = 0 ; $i <= $#numbers ; $i++ ) {
        for ( my $j = 0 ; $j <= $#numbers ; $j++ ) {
            next if $j == $i;
            for ( my $k = 0 ; $k < $#numbers ; $k++ ) {
                next if $k == $i || $k == $j;
                my @cur_triplet = ( $numbers[$i], $numbers[$j], $numbers[$k] );
                next unless two_nums_bigger(@cur_triplet) && sum(@cur_triplet) >= sum(@triplet);
                next if sum(@cur_triplet) == sum(@triplet)
                  && ( $numbers[$i] < $numbers[$j] || $numbers[$j] < $numbers[$k] );
                @triplet = @cur_triplet;
            }
        }
    }
    return \@triplet;
}

sub two_nums_bigger {
    my ( $a, $b, $c ) = @_;
    return $a + $b > $c && $b + $c > $a && $a + $c > $b ? 1 : 0;
}

