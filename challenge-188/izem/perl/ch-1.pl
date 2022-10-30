
=head1

Week 188:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-188

TASK #1: Divisible Pairs

    You are given list of integers @list of size $n and divisor $k. 
    Write a script to find out count of pairs in the given list that satisfies 
    the rules i.e The pair (i, j) is eligible if and only if
      0 <= i < j < len(list) 
      and 
      list[i] + list[j] is divisible by k

=cut

use strict;
use warnings;
use feature 'say';

use Test::More;
use Data::Dumper;

$Data::Dumper::Indent = 0;

my @cases = (
    { 'args' => [ [ 4, 5, 1, 6 ], 2 ], 'expected' => 2 },
    { 'args' => [ [ 1, 2, 3, 4 ], 2 ], 'expected' => 2 },
    { 'args' => [ [ 1, 3, 4, 5 ], 3 ], 'expected' => 2 },
    { 'args' => [ [ 5, 1, 2, 3 ], 4 ], 'expected' => 2 },
    { 'args' => [ [ 7, 2, 4, 5 ], 4 ], 'expected' => 1 },
);

for my $case (@cases) {
    cmp_ok( divisiblePairs( @{ $case->{'args'} } ),
        '==', $case->{'expected'}, Dumper( $case->{'args'} ) );
}

done_testing( scalar @cases );

sub divisiblePairs {
    my ( $integers, $divisor ) = @_;
    my @ints  = @$integers;
    my $pairs = 0;
    for ( my $i = 0 ; $i < $#ints ; $i++ ) {
        for ( my $j = $i + 1 ; $j <= $#ints ; $j++ ) {
            $pairs++ if ( $ints[$i] + $ints[$j] ) % $divisor == 0;
        }
    }
    return $pairs;
}
