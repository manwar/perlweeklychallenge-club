use Algorithm::Combinatorics 'subsets';

sub f { eval join '+', map eval join('^', @$_), subsets \@_ }

use Test::More;
is f(1, 3)             => 6;
is f(5, 1, 6)          => 28;
is f(3, 4, 5, 6, 7, 8) => 480;
done_testing;
