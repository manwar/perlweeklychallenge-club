use strict; use warnings; use v5.10; use List::Util 'uniq'; use Test::More;

sub third_max {
    my( $third_max, $max ) = ( uniq sort { $b <=> $a } @_ )[ 2, 0 ];
    $third_max // $max
}

say third_max(@ARGV) and exit if @ARGV;
is third_max(5, 6, 4, 1) => 4;
is third_max(4, 5) => 5;
is third_max(1, 2, 2, 3) => 1;
done_testing;
