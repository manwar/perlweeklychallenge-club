use strict;
use warnings;
use Algorithm::Combinatorics qw/permutations/;

sub get_10_pandigital {

    my @list = ( 2 .. 9 );
    unshift @list, 0;
    unshift @list, 1;

    my $counter = 1;
    my $iter    = permutations( \@list );

    my @result;

    while ( my $p = $iter->next ) {
        push @result, join "", @$p;
        $counter++;
        last if $counter == 11;
    }

    return \@result;
}

use Test::More;

is_deeply(
    get_10_pandigital(),
    [
        1023456789, 1023456798, 1023456879, 1023456897, 1023456978, 1023456987,
        1023457689, 1023457698, 1023457869, 1023457896
    ]
);
done_testing;
