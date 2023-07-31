#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use lib '../../../challenge-047/e-choroba/perl';
use MyRoman qw{ from_roman to_roman };

use constant {
    ZERO       => 'nulla',
    IMPOSSIBLE => 'non potest',
};

my %OP = (
    '+'  => sub { $_[0] +  $_[1] },
    '-'  => sub { $_[0] -  $_[1] },
    '/'  => sub { $_[0] /  $_[1] },
    '*'  => sub { $_[0] *  $_[1] },
    '**' => sub { $_[0] ** $_[1] },
);

sub roman_maths($expression) {
    my ($r1, $op, $r2)
        = $expression =~ m{^([IVXLCDM]+) ([-+*/]|\*\*) ([IVXLCDM]+)$}
        or die 'Parser error';

    my ($n1, $n2) = map from_roman($_), $r1, $r2;
    my $result = $OP{$op}->($n1, $n2);

    return ZERO if 0 == $result;

    return IMPOSSIBLE if $op eq '/' && $n1 % $n2
                      || $result > 3999
                      || $result < 0;

    return to_roman($result)
}

use Test::More tests => 9 + 2;

is roman_maths('IV + V'), 'IX', 'Example 1';
is roman_maths('M - I'), 'CMXCIX', 'Example 2';
is roman_maths('X / II'), 'V', 'Example 3';
is roman_maths('XI * VI'), 'LXVI', 'Example 4';
is roman_maths('VII ** III'), 'CCCXLIII', 'Example 5';

is roman_maths('V - V'), 'nulla', 'Zero';
is roman_maths('V / II'), 'non potest', 'Fraction';
is roman_maths('MMM + M'), 'non potest', 'Overflow';
is roman_maths('V - X'), 'non potest', 'Negative';

ok ! defined eval { roman_maths('ABCD ^ XYZ'); 1 }, 'Dies';
like $@, qr/^Parser error/, 'Exception';
