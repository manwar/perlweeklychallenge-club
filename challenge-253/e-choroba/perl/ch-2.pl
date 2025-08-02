#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ first };

sub weakest_row($matrix) {
    return [
        map $_->[0],
        sort { $a->[1] <=> $b->[1] || $a->[0] <=> $b->[0] }
        map [$_, scalar grep $_, @{ $matrix->[$_] }],
        0 .. $#$matrix
    ]
}

sub weakest_row_grep($matrix) {
    return [sort {
        grep($_, @{ $matrix->[$a] }) <=> grep($_, @{ $matrix->[$b] })
        || $a <=> $b
    } 0 .. $#$matrix]
}

sub weakest_row_first_schwartzian($matrix) {
    return [
        map $_->[0],
        sort { $a->[1] <=> $b->[1] || $a->[0] <=> $b->[0] }
        map { my $r = $_;
              [$r,
               (first { ! $matrix->[$r][$_] } 0 .. @{ $matrix->[$r] })
              ]  # We're using @, not $#, to prevent undef for all ones.
          } 0 .. $#$matrix
    ]
}

use Test2::V0;
plan 3 * 3;

my $SIZE = 500;

my $m = [map { my $o = int rand $SIZE;
               [(1) x $o, (0) x ($SIZE - $o)]
         } 1 .. $SIZE];

for my $f (\&weakest_row,
           \&weakest_row_grep,
           \&weakest_row_first_schwartzian,
) {
    is $f->([
        [1, 1, 0, 0, 0],
        [1, 1, 1, 1, 0],
        [1, 0, 0, 0, 0],
        [1, 1, 0, 0, 0],
        [1, 1, 1, 1, 1]
    ]), [2, 0, 3, 1, 4], 'Example 1';

    is $f->([
        [1, 0, 0, 0],
        [1, 1, 1, 1],
        [1, 0, 0, 0],
        [1, 0, 0, 0]
    ]), [0, 2, 3, 1], 'Example 2';

    is $f->($m), weakest_row_grep($m), 'same';
}

use Benchmark qw{ cmpthese };

cmpthese(-5, {
    schwartzian    => sub { weakest_row($m) },
    grep           => sub { weakest_row_grep($m) },
    first_schwartz => sub { weakest_row_first_schwartzian($m) }
});


__END__
                 Rate           grep first_schwartz    schwartzian
grep           9.22/s             --           -89%           -93%
first_schwartz 84.3/s           814%             --           -34%
schwartzian     128/s          1284%            51%             --
