use strict;
use warnings;
use Test::More tests => 2;

my @ints1   = ( 1, 34, 5, 6 );
my @digits1 = ( 1, 3,  4, 5, 6 );
is_deeply( [ split //, join( '', @ints1 ) ],
    \@digits1, 'Test 1: Separating digits from array' );

my @ints2   = ( 1, 24, 51, 60 );
my @digits2 = ( 1, 2,  4,  5, 1, 6, 0 );
is_deeply( [ map { split // } @ints2 ],
    \@digits2, 'Test 2: Separating digits from array' );
