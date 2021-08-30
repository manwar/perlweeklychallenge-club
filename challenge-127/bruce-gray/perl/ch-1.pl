use strict;
use warnings;
use 5.026;
use experimental qw<signatures>;
use List::Util   qw<uniq>;
use Test::More;

# Without uniq or input checking: my %s; return 0 + !grep { ++$s{$_} >= 2 } map { @{$_} } @_;

sub sets_are_disjoint ( $x_aref, $y_aref ) {
    my @x = @{$x_aref};
    my @y = @{$y_aref};
    die "Input set X was not unique" if @x != uniq(@x);
    die "Input set Y was not unique" if @y != uniq(@y);

    return 0 + ( @x + @y == uniq(@x, @y) );
}

my @tests = (
    [ 0 => [ [1, 2, 5, 3, 4], [4, 6, 7, 8, 9] ] ],
    [ 1 => [ [1, 3, 5, 7, 9], [0, 2, 4, 6, 8] ] ],
    [ 1 => [ [             ], [             ] ] ],
);
plan tests => 0+@tests;
for (@tests) {
    my ($expected, $input) = @{$_};
    is sets_are_disjoint(@{$input}), $expected;
}