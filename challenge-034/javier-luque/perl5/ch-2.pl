#!/usr/bin/perl
# Test: ./ch2.pl
use strict;
use warnings;
use feature qw(say);

my %dispatch_table = (
    '+' => \&add,
    '-' => \&subtract,
    'x' => sub { return ($_[0] * $_[1]); },
    '/' => sub { return ($_[0] / $_[1]); },
);

my @equations = ('2 + 2', '10 - 4', '3 x 3', '25 / 5');
for my $equation (@equations) {
    next unless ($equation =~ /^(\d+)\s*([\+\-x\/])\s*(\d+)$/);

    # $1 = left, $2 = operator, $3 = right
    say $equation . ' = ' .
        $dispatch_table{$2}->($1, $3);
}

sub add      { return ($_[0] + $_[1]); }
sub subtract { return ($_[0] - $_[1]); }

