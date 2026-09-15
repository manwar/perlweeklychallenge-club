#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use POSIX qw{ ceil };

sub array_median_naive($arr1, $arr2) {
    my @m = sort { $a <=> $b } @$arr1, @$arr2;
    return unless @m;

    return @m % 2 ? $m[ $#m / 2 ] : ($m[ $#m / 2 ] + $m[ @m / 2 ]) / 2
}

# Optimized. Doesn't store the sorted array.
sub array_median_opt($arr1, $arr2) {
    my $size = @$arr1 + @$arr2;
    return if 0 == $size;

    my @m = (sort { $a <=> $b } @$arr1, @$arr2)
            [ $size % 2 ? $size / 2
                        : $size / 2 - 1, $size / 2 ];
    return @m == 1 ? $m[0] : ($m[0] + $m[1]) / 2
}

# Mmemory efficient. Only a constant size array needed.
sub array_median_sliding($arr1, $arr2) {
    my $pos = (@$arr1 + @$arr2 - 1) / 2;
    return if $pos < 0;

    my $size = 2 - (@$arr1 + @$arr2) % 2;

    my @indices = (0, 0);
    my @m;
    for my $step (0 .. ceil($pos)) {
        if ($indices[0] > $#$arr1) {
            push @m, $arr2->[ $indices[1] ]
                if $step >= ceil($pos) - 2;
            ++$indices[1];
        } elsif ($indices[1] > $#$arr2
                 || $arr1->[ $indices[0] ] <= $arr2->[ $indices[1] ]
        ) {
            push @m, $arr1->[ $indices[0] ]
                if $step >= ceil($pos) - 2;
            ++$indices[0];
        } else {
            push @m, $arr2->[ $indices[1] ]
                if $step >= ceil($pos) - 2;
            ++$indices[1];
        }
    }
    return $size == 1 ? $m[-1] : ($m[-1] + $m[-2]) / 2
}

my @F;
BEGIN {
    @F = ([naive => \&array_median_naive],
          [sliding => \&array_median_sliding],
          [opt => \&array_median_opt])
}

use Test::More tests => @F * (5 + 3) + (@F - 1);

for my $f (@F) {
    is $f->[1]([2], [4]), 3.0, $f->[0] . ' Example 1';
    is $f->[1]([1,2,3], [7,8,9,10]), 7.0, $f->[0] . ' Example 2';
    is $f->[1]([], [10,20,30,40]), 25.0, $f->[0] . ' Example 3';
    is $f->[1]([100], [1,2,3,4,5,6,7]), 4.5, $f->[0] . ' Example 4';
    is $f->[1]([1,2,2], [2,2,3]), 2.0, $f->[0] . ' Example 5';

    is $f->[1]([], []), undef, $f->[0] . ' Both empty';
    is $f->[1]([2], []), 2, $f->[0] . ' Single element in arr1';
    is $f->[1]([], [2]), 2, $f->[0] . ' Single element in arr2';
}

use Benchmark qw{ cmpthese };

my $l1 = [sort { $a <=> $b } map rand 100, 1 .. 20000];
my $l2 = [sort { $a <=> $b } map rand 100, 1 .. 20000];

for my $fi (@F[1 .. $#F]) {
    is $fi->[1]($l1, $l2), $F[0][1]($l1, $l2), "same $fi->[0]";
}

cmpthese(-3, {
    map { my $f = $_; $f->[0] => sub { $f->[1]($l1, $l2) } } @F
});

__END__
         Rate sliding   naive     opt
sliding 111/s      --    -62%    -87%
naive   292/s    163%      --    -66%
opt     869/s    684%    198%      --
