#!/usr/bin/perl
use warnings;
use strict;

{   package Damm::Algorithm;
    use Moo;
    use experimental 'signatures';

    has table => (is => 'ro', required => 1);

    sub calculate_check_digit ($self, $n) {
        my $interim = 0;
        for my $digit (split //, $n) {
            $interim = $self->table->[$interim][$digit];
        }
        return $interim
    }

    sub is_valid ($self, $n) {
        return 0 == $self->calculate_check_digit($n)
    }
}

use Test::More tests => 4;

my $damm = 'Damm::Algorithm'->new(
    table => [
        [qw[ 0  3  1  7  5  9  8  6  4  2 ]],
        [qw[ 7  0  9  2  1  5  4  8  6  3 ]],
        [qw[ 4  2  0  6  8  7  1  3  5  9 ]],
        [qw[ 1  7  5  0  9  8  3  4  2  6 ]],
        [qw[ 6  1  2  3  0  4  5  9  7  8 ]],
        [qw[ 3  6  7  4  2  0  9  5  8  1 ]],
        [qw[ 5  8  6  9  7  2  0  1  3  4 ]],
        [qw[ 8  9  4  5  3  6  2  0  1  7 ]],
        [qw[ 9  4  3  8  6  1  7  2  0  5 ]],
        [qw[ 2  5  8  1  4  3  6  7  9  0 ]]]);

ok $damm->is_valid(5724);
ok ! $damm->is_valid(5727);
is $damm->calculate_check_digit(572), 4;

# See Algorithm::Damm on CPAN.
my $n = 43881234567;
my $d = $damm->calculate_check_digit($n);
ok $damm->is_valid("$n$d");
