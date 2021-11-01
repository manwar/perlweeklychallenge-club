use 5.24.0;
use warnings;
use experimental qw<signatures>;
use Test::More;

# From https://oeis.org/A000119 :
#   a(n) = f(n,1,1) with f(x,y,z) = if x<y then 0^x else f(x-y,y+z,y)+f(x,y+z,y).
# XXX Cached version gives huge speed-up.
sub f ( $x, $y, $z ) {
    return 0 ** $x if $x < $y;

    return f( $x - $y, $y + $z, $y )
         + f( $x     , $y + $z, $y );
}
sub Fibonacci_partitions ( $n ) { return f($n, 1, 1) }

use Test::More;
my @tests = (
    [ 16, 4],
    [  9, 2],
    [ 15, 2],
);
# From https://oeis.org/A000119/list :
my @A000119_list = (
    1,1,1,2,1,2,2,1,3,2,2,3,1,3,3,2,4,2,3,3,1,4,3,3,
    5,2,4,4,2,5,3,3,4,1,4,4,3,6,3,5,5,2,6,4,4,6,2,5,5,
    3,6,3,4,4,1,5,4,4,7,3,6,6,3,8,5,5,7,2,6,6,4,8,4,6,
    6,2,7,5,5,8,3,6,6,3,7,4,4,5,1,5,5,4,8,4,7,7,3,9,6,
    6,9,3,8,8,5
);
plan tests => @tests + 1;
for (@tests) {
    my ($input, $expected) = @{$_};
    is Fibonacci_partitions($input), $expected,
      "Fibonacci_partitions($input)==$expected";
}

is_deeply [map {Fibonacci_partitions($_)} keys @A000119_list],
          \@A000119_list,
          'Whole A000119 list matches';
