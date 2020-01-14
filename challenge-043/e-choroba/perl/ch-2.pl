#!/usr/bin/perl
use warnings;
use strict;

use Convert::AnyBase;

my %irregular = (
    1 => undef,
    2 => undef,
    3 => undef,
    4 => 1210,
    5 => 21200,
    6 => undef,
);
sub self_descriptive_number {
    my ($base) = @_;
    my $set = join "", ('0' .. '9', 'A' .. 'Z')[0 .. $base - 1];
    my $convert = @_ == 1
        ? sub { $_[0] }
        : sub { 'Convert::AnyBase'->new(set => $set)->decode($_[0]) };

    if (exists $irregular{$base}) {
        die "No self descriptive number in base $base.\n"
            unless $irregular{$base};

        return $convert->($irregular{$base})
    }

    return $convert->(join "",
                      map $_ > 9 ? chr 55 + $_ : $_,
                      ($base - 4, 2, 1, (0) x ($base - 7), 1, (0) x 3))
}

use Test::More;
use Test::Exception;

throws_ok { self_descriptive_number(1) } qr/base 1/, 'base 1';
throws_ok { self_descriptive_number(2) } qr/base 2/, 'base 2';
throws_ok { self_descriptive_number(3) } qr/base 3/, 'base 3';
throws_ok { self_descriptive_number(6) } qr/base 6/, 'base 6';

is self_descriptive_number(4), 1210, 'base 4';
is self_descriptive_number(5), 21200, 'base 5';

is self_descriptive_number(7), 3211000, 'base 7';
is self_descriptive_number(8), 42101000, 'base 8';
is self_descriptive_number(9), 521001000, 'base 9';
is self_descriptive_number(10), 6210001000, 'base 10';
is self_descriptive_number(11), 72100001000, 'base 11';
is self_descriptive_number(12), 821000001000, 'base 12';

is self_descriptive_number(16), 'C210000000001000', 'base 16';
is self_descriptive_number(36), 'W21000' . '0' x 23  . '0001000', 'base 36';

is self_descriptive_number(4, 1), 100, 'base 4 in 10';
is self_descriptive_number(5, 1), 1425, 'base 5 in 10';
is self_descriptive_number(7, 1), 389305, 'base 7 in 10';
is self_descriptive_number(8, 1), 8946176, 'base 8 in 10';
is self_descriptive_number(9, 1), 225331713, 'base 9 in 10';
is self_descriptive_number(10, 1), 6210001000, 'base 10 in 10';
is self_descriptive_number(11, 1), 186492227801, 'base 11 in 10';
is self_descriptive_number(12, 1), 6073061476032, 'base 12 in 10';
is self_descriptive_number(16, 1), 13983676842985394176, 'base 16 in 10';

like self_descriptive_number(36, 1), qr/9\.47329.*e\+55/, 'base 36 in 10';

done_testing();
