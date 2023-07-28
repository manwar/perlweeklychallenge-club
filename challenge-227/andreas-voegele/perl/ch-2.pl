#!/usr/bin/perl

# Write a script to handle a 2-term arithmetic operation expressed in Roman numeral.
#
# Example
#
# IV + V     => IX
# M - I      => CMXCIX
# X / II     => V
# XI * VI    => LXVI
# VII ** III => CCCXLIII
# V - V      => nulla (they knew about zero but didn't have a symbol)
# V / II     => non potest (they didn't do fractions)
# MMM + M    => non potest (they only went up to 3999)
# V - X      => non potest (they didn't do negative numbers)

use 5.036;
use utf8;

package Roman;

use experimental qw(for_list);

use List::Util qw(reduce);

my %number_for = (
    I => 1,
    V => 5,
    X => 10,
    L => 50,
    C => 100,
    D => 500,
    M => 1000,
);

my @numeral_for = (
    1000 => 'M',
    900  => 'CM',
    500  => 'D',
    400  => 'CD',
    100  => 'C',
    90   => 'XC',
    50   => 'L',
    40   => 'XL',
    10   => 'X',
    9    => 'IX',
    5    => 'V',
    4    => 'IV',
    1    => 'I',
);

sub decode_roman ($string) {
    my @numbers = map { $number_for{$_} // 0 } split //, $string;
    my $pair    = reduce {
        my ($sum, $prev) = @{$a};
        $b <= $prev ? [$sum + $prev, $b] : [$sum - $prev, $b]
    } [0, 0], @numbers;
    return $pair->[0] + $pair->[1];
}

sub encode_roman ($number) {
    if (   !defined $number
        || $number < 0
        || $number > 3999
        || $number != int $number) {
        return 'non potest ';
    }
    if ($number == 0) {
        return 'nulla';
    }
    my $string = q{};
    for my ($multiple, $numeral) (@numeral_for) {
        while ($number >= $multiple) {
            $number -= $multiple;
            $string .= $numeral;
        }
    }
    return $string;
}

sub new ($class, $string) {
    my $number = decode_roman($string);
    return bless \$number, $class;
}

sub from_number ($class, $number) {
    return bless \$number, $class;
}

sub _other ($value) {
    my $type = ref $value;
    if ($type eq 'Roman') {
        return ${$value};
    }
    return $value;
}

use overload
    '+'   => sub { Roman->from_number(${$_[0]} + _other($_[1])) },
    '-'   => sub { Roman->from_number(${$_[0]} - _other($_[1])) },
    '*'   => sub { Roman->from_number(${$_[0]} * _other($_[1])) },
    '/'   => sub { Roman->from_number(${$_[0]} / _other($_[1])) },
    '%'   => sub { Roman->from_number(${$_[0]} % _other($_[1])) },
    '**'  => sub { Roman->from_number(${$_[0]}**_other($_[1])) },
    '<=>' => sub { ${$_[0]} <=> _other($_[1]) },
    '++'  => sub { ++${$_[0]} },
    '--'  => sub { --${$_[0]} },
    'int' => sub { int ${$_[0]} },
    '""'  => sub { encode_roman(${$_[0]}) };

package main;

sub roman ($string) {
    return Roman->new($string);
}

say roman('IV') + roman('V');
say roman('M') - roman('I');
say roman('X') / roman('II');
say roman('XI') * roman('VI');
say roman('VII')**roman('III');
say roman('V') - roman('V');
say roman('V') / roman('II');
say roman('MMM') + roman('M');
say roman('V') - roman('X');
