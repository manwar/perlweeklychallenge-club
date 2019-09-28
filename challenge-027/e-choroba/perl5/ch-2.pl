#!/usr/bin/perl
use warnings;
use strict;

{   package Historical;
    use Tie::Scalar;
    use parent -norequire => 'Tie::StdScalar';

    sub TIESCALAR { bless [], shift }
    sub FETCH     { $_[0][-1] }
    sub STORE     { push @{ $_[0] }, $_[1] }

    sub history   { $_[0] }
}

tie my $x, 'Historical';
$x = 'initial value';
$x = 'second value';
$x = 'last value';

use Test::More tests => 2;
is_deeply tied($x)->history,
    [ 'initial value', 'second value', 'last value' ];

tie my $y, 'Historical';
$y = 10;
$y = 20;
$y -= 5;

is_deeply tied($y)->history,
    [ 10, 20, 15 ];
